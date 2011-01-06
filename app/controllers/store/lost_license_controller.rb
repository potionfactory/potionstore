class Store::LostLicenseController < ApplicationController
  layout "store"

  def index
  end

  def retrieve
    if params[:email].blank?
      flash[:license_notice] = "We can't do much without an email address"
      render :action => 'index' and return
    end

    email = params[:email].strip().downcase()
    orders = Order.find(:all, :conditions => ["status='C' AND LOWER(email)=?", email])
    if orders.empty?
      flash[:license_notice] = "Could not find any orders for " + email
      @email = email
      render :action => 'index' and return
    end
    for order in orders
      OrderMailer.deliver_thankyou(order, bcc = false)
      if $STORE_PREFS['send_lost_license_sent_notification_email']
        OrderMailer.deliver_lost_license_sent(order)
      end
    end
    redirect_to :action => 'sent'
  end
end
