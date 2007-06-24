class AdminController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
  :redirect_to => { :action => :list }

  # Authentication stuff
  before_filter :check_authentication, :except => [:signin_form, :signin]
  def check_authentication
    unless session[:logged_in]
      session[:intended_action] = action_name
      render :action => "signin_form", :layout => 'error'
    end
  end

  def signin_form
    render :action => 'signin_form', :layout => 'error'
  end

  def signin
    if params[:username] == $STORE_PREFS['admin_username'] &&
       params[:password] == $STORE_PREFS['admin_password']
      session[:logged_in] = true
      redirect_to :action => session[:intended_action]
    else
      flash[:notice] = "Go home kid. This ain't for you."
      render :action => "signin_form", :layout => 'error'
    end
  end

  def signout
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
      return "
        select (select count(*)
                  from orders
                 where status = 'C' and
                       payment_type != 'free' and
                       current_date - #{days} <= order_time) as orders,
               sum(line_items.unit_price * quantity)
                 - sum(coalesce(coupons.amount, 0))
                 - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as earned,
               sum(quantity) as q,
               products.name as product

        from orders
             inner join line_items on orders.id = line_items.order_id
             left outer join products on products.id = line_items.product_id
             left outer join coupons on coupons.id = orders.coupon_id

        where status = 'C' and lower(payment_type) != 'free' and current_date - #{days} <= order_time

        group by product"
    end

    @reports['Today'] = Order.find_by_sql(last_n_days_sql(1))
    @reports['Last 7 Days'] = Order.find_by_sql(last_n_days_sql(7))
    @reports['Last 30 Days'] = Order.find_by_sql(last_n_days_sql(30))
    @reports['Last 365 Days'] = Order.find_by_sql(last_n_days_sql(365))

    @report_num_orders = {}
    @report_totals = {}
  
    for key in ['Today', 'Last 7 Days', 'Last 30 Days', 'Last 365 Days']
      report = @reports[key]
      orders = 0
      total = 0
      for product in report
        orders = product.orders
        total += product.earned if product
      end
      @report_num_orders[key] = orders
      @report_totals[key] = total
    end

    # NOTE: mysql uses year, month, and day functions instead of date_part

    last_8_days_sql = "
        select date_part('year', orders.order_time) as year,
               date_part('month', orders.order_time) as month,
               date_part('day', orders.order_time) as day,
               sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                  - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as earned,
               max(orders.order_time) as last_time

        from orders 
             inner join line_items on orders.id = line_items.order_id 
             left outer join coupons on coupons.id = orders.coupon_id 

        where status = 'C' and payment_type != 'Free'

        group by year, month, day

        order by last_time desc limit 8"

    last_8_months_sql = "
        select date_part('year', orders.order_time) as year,
               date_part('month', orders.order_time) as month,
               sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                  - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as earned,
               max(orders.order_time) as last_time

        from orders
             inner join line_items on orders.id = line_items.order_id
             left outer join coupons on coupons.id = orders.coupon_id

        where status = 'C' and payment_type != 'Free'

        group by year, month

        order by last_time desc limit 8"

    @daily = Order.find_by_sql(last_8_days_sql)
    @monthly = Order.find_by_sql(last_8_months_sql)

    # Calculate a very simple estimate.
    # Takes the average daily sales from the last 30 days to extrapolate the sales
    # for the remaining days of the current month
    today = Date.today
    days_in_current_month = Date.civil(today.year, today.month, -1).day

    if @monthly != nil and @monthly.length > 0
      @month_estimate = @monthly.first.earned.to_f + @report_totals['Last 30 Days'] / 30 * (days_in_current_month - today.day)
      @year_estimate = @month_estimate * 12
    end

  end

  # Order actions
  def find_orders
    q = params[:query]
    q.strip!
    redirect_to :back and return if not q
    conditions = "status != 'P' AND (email ~* '#{q}' OR
                                     first_name ~* '#{q}.*' OR
                                     last_name ~* '#{q}.*' OR
                                     licensee_name ~* '%#{q}.*' OR
                                     id = #{q})"
    @order_pages, @orders = paginate :orders, :per_page => 100, :order => 'order_time DESC', :conditions => conditions
    render :action => "orders"
  end
  
  def orders
    @order_pages, @orders = paginate :orders, :per_page => 100, :order => 'order_time DESC', :conditions => "status != 'P'"
  end

  def order
    @order = Order.find(params[:id])
  end

  def add_order
    @order = Order.new()
    @order.country = 'US'
    @order.payment_type = 'Free'
  end

  def edit_order
    @order = Order.find(params[:id])
  end

  def modify_order
    # must delete the licensee name from parameters because we need to set it after the line items are added
    licensee_name = params[:order][:licensee_name]
    params[:order].delete("licensee_name")
    
    if params[:order] && !params[:order][:id].blank?
      @order = Order.find(params[:order][:id])
      @order.attributes = params[:order]
    else
      @order = Order.new(params[:order])
      @order.status = 'C'
    end
    begin
      @order.transaction do
        if not @order.add_or_update_items(params[:items])
          flash[:notice] = 'Order contains no items'
          raise "Problem"
        end
        @order.update_item_prices(params[:item_prices])
        @order.skip_cc_validation = true
        @order.licensee_name = licensee_name
        if not @order.save()
          flash[:notice] = 'Problem saving order'
          raise "Problem"
        end
      end
    rescue
      redirect_to :back and return
    end
    redirect_to :action => "order", :id => @order.id
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.status = 'X'
    @order.update()
    redirect_to :action => 'order', :id => @order.id
  end

  def uncancel_order
    @order = Order.find(params[:id])
    @order.status = 'C'
    @order.update()
    redirect_to :action => 'order', :id => @order.id
  end

  def send_order_emails
    @order = Order.find(params[:id])
    OrderMailer.deliver_thankyou(@order) # if is_live()
    redirect_to :action => 'order', :id => @order.id
  end


  # Product actions
  # Modifying a product doesn't happen often enough, so I am doing it directly through the
  # database for now.
  def products # unused
    @product_pages, @products = paginate :products, :per_page => 10
  end

  def product # unused
    @product = Product.find(params[:id])
  end

  def new_product # unused
    @product = Product.new
  end

  def create_product # unused
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = 'Product was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit_product # unused
    @product = Product.find(params[:id])
  end

  def update_product # unused
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Product was successfully updated.'
      redirect_to :action => 'show', :id => @product
    else
      render :action => 'edit'
    end
  end

  def destroy_product # unused
    Product.find(params[:id]).destroy
    redirect_to :action => 'list'
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

  def add_coupons # unused
    if params[:form]
      form = params[:form]
      lines = form[:coupons].split("\r\n")
      lines.reject! {|x| x.strip == ''}
      for line in lines
        coupon = Coupon.new
        coupon.code = form[:code]
        coupon.coupon = line.strip()
        coupon.product_code = 'x'
        coupon.description = form[:description].strip()
        coupon.amount = form[:amount].strip()
        coupon.save()
      end
    end
  end

  def mass_order # unused
    if params[:form]
      form = params[:form]
      for key in form.keys()
        form[key] = form[key].strip()
      end
      lines = form[:people].split("\r\n")
      lines.reject! {|x| x.strip == ''}
      for line in lines
        fname, lname, email = line.split(",").collect{|x| x.strip}
        order = Order.new

        # add item
        order.order_time = Time.now()

        order.add_form_items(params[:items])
        order.update_item_prices(params[:item_prices])

        order.first_name = fname
        order.last_name = lname
        order.email = email

        order.address1 = 'n/a'
        order.address2 = ''
        order.city = 'n/a'
        order.state = 'n/a'
        order.zipcode = 'n/a'
        order.country = 'XX'

        order.payment_type = form[:payment_type]
        order.cc_number = 'XXXXXXXXXXXXXXXX'
        order.cc_month = 'n/a'
        order.cc_year = 'n/a'
        order.cc_code = 'n/a'

        order.comment = ''
        
        order.status = 'C'
        order.save()

        coupons = order.add_promo_coupons()
        
        email = OrderMailer.deliver_thankyou(order)
      end
    end
  end

end
