class Admin::ChartsController < ApplicationController

  before_filter :check_authentication

  def last_30_days
    query_results = Order.find_by_sql(
        "select date_part('year', orders.order_time) as year,
                date_part('month', orders.order_time) as month,
                date_part('day', orders.order_time) as day,
                extract('day' from age(orders.order_time)) + 1 as days_ago,
                sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                    - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as revenue,
                max(orders.order_time) as last_time

         from orders
              inner join line_items on orders.id = line_items.order_id
              left outer join coupons on coupons.id = orders.coupon_id

         where status = 'C' and lower(payment_type) != 'free' and current_date - 30 <= order_time

         group by year, month, day, days_ago

         order by last_time desc limit 30")

    labels = []
    data = []
    
    0.upto(29) {
      labels += ['']
      data += [0]
    }

    query_results.each {|day|
      xindex = -day.days_ago.to_i + 29
      next if xindex < 0 || xindex > 29
      revenue = day.revenue.to_f.round

      d = Date.strptime("#{day.month}/#{day.day}", '%m/%d')
      labels[xindex] = d.wday == 0 ? "#{day.month}/#{day.day}" : ""
      data[xindex] = revenue
    }
    
    g = new_chart(data, labels)
    
    render :text => g.render
  end

  def last_12_months
    query_results = Order.find_by_sql(
        "select date_part('year', orders.order_time) as year,
                date_part('month', orders.order_time) as month,
                extract('month' from age(date_trunc('month', orders.order_time))) as months_ago,
                sum(line_items.unit_price * quantity) - sum(coalesce(coupons.amount, 0))
                    - sum(line_items.unit_price * quantity * coalesce(percentage, 0) / 100) as revenue,
                max(orders.order_time) as last_time

         from orders
              inner join line_items on orders.id = line_items.order_id
              left outer join coupons on coupons.id = orders.coupon_id

         where status = 'C' and lower(payment_type) != 'free'

         group by year, month, months_ago

         order by last_time desc limit 12")

    labels = []
    data = []
    
    0.upto(11) {
      labels += ['']
      data += [0]
    }

    query_results.each {|month|
      xindex = -month.months_ago.to_i + 11
      next if xindex < 0 || xindex > 11
      revenue = month.revenue.to_f.round

      d = Date.strptime("#{month.month}/#{month.year}", '%m/%y')
      labels[xindex] = "#{month.month}/#{month.year}"
      data[xindex] = revenue
    }
    
    g = new_chart(data, labels)
    g.set_x_label_style(10, '#000000', 0, 2)
    
    render :text => g.render
  end

  private
  def new_chart(data, labels)
    g = OpenFlashChart.new

    g.set_data(data)
    g.bar_filled(75, '#000000', '#333333', ' ', 10)
    g.set_bg_color('#FFFFFF')

    g.set_x_labels(labels)
    g.set_x_label_style(10, '#000000', 0, 1)
    g.set_x_axis_steps(0)

    g.set_y_max((data.max/100).ceil * 100)
    g.set_y_label_steps(5)

    g.instance_variable_set :@y_axis_color, '#AAAAAA'
    g.instance_variable_set :@x_axis_color, '#666666'
    g.instance_variable_set :@y_grid_color, '#CCCCCC'
    g.instance_variable_set :@x_grid_color, '#FFFFFF'

    g.set_tool_tip('#x_label#<br>$#val#');
    
    return g
  end
end
