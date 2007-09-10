class AdminController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :list }

  # Authentication stuff
  before_filter :check_authentication, :except => [:login]

  def login
    unless params[:username] && params[:password]
      render :action => "login", :layout => 'error' and return
    end

    if params[:username] == $STORE_PREFS['admin_username'] &&
       params[:password] == $STORE_PREFS['admin_password']
      session[:logged_in] = true
      if session[:intended_url] != nil
        redirect_to session[:intended_url]
      else
        redirect_to :action => 'index'
      end
    else
      flash[:notice] = "Go home kid. This ain't for you."
      render :action => "login", :layout => 'error'
    end
  end

  def logout
    session[:logged_in] = nil
    redirect_to home_url
  end

  # Dashboard page
  def index

    @reports = {}

    if Product.count == 0
      flash[:notice] = "This store doesn't have any products! Add some!"
      redirect_to :action => 'products' and return
    end

    # NOTE: We have to use SQL because performance is completely unacceptable otherwise

    # helper function
    def last_n_days_sql(days)
      # NOTE: mysql should use IFNULL instead of COALESCE
      days = days - 1
      return "
        select (select count(*)
                  from orders
                 where status = 'C' and
                       lower(payment_type) != 'free' and
                       current_date - #{days} <= order_time) as orders,
               sum(line_items.unit_price * quantity)
                 - sum(coalesce(coupons.amount, 0))
                 - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as revenue,
               sum(quantity) as quantity,
               products.name as product_name

        from orders
             inner join line_items on orders.id = line_items.order_id
             left outer join products on products.id = line_items.product_id
             left outer join coupons on coupons.id = orders.coupon_id

        where status = 'C' and lower(payment_type) != 'free' and current_date - #{days} <= order_time

        group by product_name"
    end

    @reports['Today'] = Order.find_by_sql(last_n_days_sql(1))
    @reports['7 Days'] = Order.find_by_sql(last_n_days_sql(7))
    @reports['30 Days'] = Order.find_by_sql(last_n_days_sql(30))
    @reports['365 Days'] = Order.find_by_sql(last_n_days_sql(365))

    @report_num_orders = {}
    @report_totals = {}

    @products = @reports['365 Days'].map{|p| p.product_name}

    @table = []
    @table += [['', 'Today', '7 Days', '30 Days', '365 Days']]

    for key in ['Today', '7 Days', '30 Days', '365 Days']
      report = @reports[key]
      orders = 0
      total = 0
      for product in report
        orders = product.orders
        total += product.revenue if product
      end
      @report_num_orders[key] = orders
      @report_totals[key] = total
    end

    row = ['Orders']
    for key in ['Today', '7 Days', '30 Days', '365 Days']
      row += [@report_num_orders[key]]
    end
    @table += [row]

    for product_name in @products
      row = [product_name]
      for key in ['Today', '7 Days', '30 Days', '365 Days']
        qty = 0
        for product in @reports[key]
          if product.product_name == product_name
            qty = product.quantity
          end
        end
        row += [qty]
      end
      @table += [row]
    end

    # NOTE: mysql uses year, month, and day functions instead of date_part

    last_8_days_sql = "
        select date_part('year', orders.order_time) as year,
               date_part('month', orders.order_time) as month,
               date_part('day', orders.order_time) as day,
               sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                  - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as revenue,
               max(orders.order_time) as last_time

        from orders
             inner join line_items on orders.id = line_items.order_id
             left outer join coupons on coupons.id = orders.coupon_id

        where status = 'C' and lower(payment_type) != 'free'

        group by year, month, day

        order by last_time desc limit 8"

    last_8_months_sql = "
        select date_part('year', orders.order_time) as year,
               date_part('month', orders.order_time) as month,
               sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                  - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as revenue,
               max(orders.order_time) as last_time

        from orders
             inner join line_items on orders.id = line_items.order_id
             left outer join coupons on coupons.id = orders.coupon_id

        where status = 'C' and lower(payment_type) != 'free'

        group by year, month

        order by last_time desc limit 8"

    @daily = Order.find_by_sql(last_8_days_sql)
    @monthly = Order.find_by_sql(last_8_months_sql)

    # Calculate a very simple projection.
    # Takes the average daily sales from the last 30 days to extrapolate the sales
    # for the remaining days of the current month
    today = Date.today
    days_in_current_month = Date.civil(today.year, today.month, -1).day

    if @monthly != nil and @monthly.length > 0
      @month_estimate = @monthly.first.revenue.to_f + @report_totals['30 Days'] / 30 * (days_in_current_month - today.day)
      @year_estimate = @month_estimate * 12
    end

    @graph_days = OpenFlashChart.swf_object(500, 150, '/admin/charts/last_30_days')
    @graph_months = OpenFlashChart.swf_object(500, 150, '/admin/charts/last_12_months')
  end

  # Coupon actions
  def generate_coupons
    if params[:form]
      form = params[:form]
      @coupons = []
      1.upto(Integer(form[:quantity])) { |i|
        coupon = Coupon.new
        coupon.code = form[:code]
        coupon.product_code = form[:product_code]
        coupon.description = form[:description]
        coupon.amount = form[:amount]
        coupon.use_limit = form[:use_limit]
        coupon.save()
        @coupons << coupon
      }
      flash[:notice] = 'Coupons generated'
    end
  end

#   def add_coupons # unused
#     if params[:form]
#       form = params[:form]
#       lines = form[:coupons].split("\r\n")
#       lines.reject! {|x| x.strip == ''}
#       for line in lines
#         coupon = Coupon.new
#         coupon.code = form[:code]
#         coupon.coupon = line.strip()
#         coupon.product_code = 'x'
#         coupon.description = form[:description].strip()
#         coupon.amount = form[:amount].strip()
#         coupon.save()
#       end
#     end
#   end

#   def mass_order # unused
#     if params[:form]
#       form = params[:form]
#       for key in form.keys()
#         form[key] = form[key].strip()
#       end
#       lines = form[:people].split("\r\n")
#       lines.reject! {|x| x.strip == ''}
#       for line in lines
#         fname, lname, email = line.split(",").collect{|x| x.strip}
#         order = Order.new

#         # add item
#         order.order_time = Time.now()

#         order.add_form_items(params[:items])
#         order.update_item_prices(params[:item_prices])

#         order.first_name = fname
#         order.last_name = lname
#         order.email = email

#         order.address1 = 'n/a'
#         order.address2 = ''
#         order.city = 'n/a'
#         order.state = 'n/a'
#         order.zipcode = 'n/a'
#         order.country = 'XX'

#         order.payment_type = form[:payment_type]
#         order.cc_number = 'XXXXXXXXXXXXXXXX'
#         order.cc_month = 'n/a'
#         order.cc_year = 'n/a'
#         order.cc_code = 'n/a'

#         order.comment = ''

#         order.status = 'C'
#         order.save()

#         coupons = order.add_promo_coupons()

#         email = OrderMailer.deliver_thankyou(order)
#       end
#     end
#   end

end
