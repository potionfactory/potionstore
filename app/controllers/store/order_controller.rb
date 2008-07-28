
class Store::OrderController < ApplicationController
  layout "store"

  before_filter :redirect_to_ssl

  def index
    new
    render :action => 'new'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def new
    session[:order] = nil
    @qty = {}
    @payment_type = session[:payment_type]
    @products = Product.find(:all, :conditions => {:active => 1})
    if params[:product]
      @qty[params[:product]] = 1
    elsif session[:items]
      for key in session[:items].keys
        @qty[Product.find(key).code] = session[:items][key]
      end
    end
  end

  def payment
    session[:order] = nil
    redirect_to :action => 'index' and return if !params[:items]
    @order = Order.new
    session[:payment_type] = params[:payment_type]

    session[:items] = params[:items]

    if not @order.add_form_items(params[:items])
      flash[:notice] = 'Nothing to buy!'
      redirect_to :action => 'index' and return
    end

    coupon_text = params[:coupon].strip
    @order.coupon_text = coupon_text

    if coupon_text != '' && @order.coupon == nil
      coupon = Coupon.find_by_coupon(coupon_text)
      if coupon != nil && coupon.expired?
        flash[:notice] = 'Coupon Expired'
      else
        flash[:notice] = 'Invalid Coupon'
      end
      session[:coupon_text] = params[:coupon].strip
      redirect_to :action => 'index' and return
    end

    if @order.total <= 0
      flash[:notice] = 'Nothing to buy!'
      redirect_to :action => 'index' and return
    end

    # Handle Paypal orders
    if params[:payment_type] == 'paypal'
      res =  Paypal.express_checkout(:amount => String(@order.total),
                                     :cancelURL => url_for(:action => 'index'),
                                     :returnURL => url_for(:action => 'confirm_paypal'),
                                     :noShipping => 1,
                                     :cpp_header_image => $STORE_PREFS['paypal_express_checkout_header_image'])
      if res.ack == 'Success' || res.ack == 'SuccessWithWarning'
        # Need to copy the string. For some reason, it tries to render the payment action otherwise
        @order.paypal_token = String.new(res.token)
        session[:order] = @order
        redirect_to Paypal.express_checkout_redirect_url(res.token) and return
      else
        flash[:notice] = 'Could not connect to PayPal'
        redirect_to :action => 'index' and return
      end

    # Handle Google Checkout orders
    elsif params[:payment_type] == 'gcheckout'
      render :action => 'payment_gcheckout' and return
    end

    # credit card order

    # put in a dummy credit card number for testing
    @order.cc_number = '4916306176169494' if not is_live?()

    render :action => 'payment_cc'
  end

  def redirect
    redirect_to :action => 'index'
  end

  def create
    if params[:order] == nil
      render :json => '["What?"]', :status => :unprocessable_entity and return
    end

#     if session[:order] != nil && session[:order].status == 'C'
#       @order = session[:order]
#       render :xml => @order.to_xml(:include => [:line_items]) and return
#     end

    @order = Order.new(params[:order])

    session[:order] = @order
    session[:items] = nil

    if not @order.save()
      render :json => @order.errors.full_messages.to_json, :status => :unprocessable_entity and return
    end

    # Actually send out the payload
    if @order.cc_order?
      # TODO: make sure to switch this back on
      success = @order.paypal_directcharge(request)
      @order.status = success ? 'C' : 'F'
      if success
        @order.finish_and_save()
        render :json => @order.to_json(:include => [:line_items])
      else
        render :json => @order.errors.full_messages.to_json, :status => :unprocessable_entity and return
      end
    end
  end

  def purchase
    redirect_to :action => 'index' and return unless params[:order] && params[:items]

    if session[:order] != nil && session[:order].status == 'C'
      @order = session[:order]
      render :action => 'failed', :layout => 'error' and return
    end

    # We need the next two ugly lines because Safari's autofill sucks
    params[:order][:address1] = params[:address1]
    params[:order][:address2] = params[:address2]

    params[:order].keys.each { |x| params[:order][x] = params[:order][x].strip if params[:order][x] != nil }

    @order = Order.new(params[:order])

    # the order in the session is a bogus temporary one
    @order.add_form_items(params[:items])

    if params[:coupon]
      @order.coupon_text = params[:coupon]
    end

    @order.order_time = Time.now()
    session[:order] = @order
    session[:items] = nil

    if not @order.save()
      flash[:error] = 'Please fill out all fields'
      if @order.cc_order?
        render :action => 'payment_cc' and return
      else
        render :action => 'payment_gcheckout' and return
      end
    end

    # Actually send out the payload
    if @order.cc_order?
      success = @order.paypal_directcharge(request)
      finish_order(success)
    else
      # Google Checkout order
      redirect_url = @order.send_to_google_checkout(url_for(:action => 'index'))
      if redirect_url == nil
        @order.failure_reason = 'Could not connect to Google Checkout'
        render :action => 'failed', :layout => 'error' and return
      end
      redirect_to redirect_url and return
    end
  end

  def confirm_paypal
    render :action => 'no_order', :layout => 'error' and return if session[:order] == nil

    @order = session[:order]
    redirect_to :action => 'index' and return if @order == nil || @order.paypal_token != params[:token]

    # Suck the info from PayPal
    res = Paypal.express_checkout_details(:token => @order.paypal_token)

    if res.ack != 'Success' && res.ack != 'SuccessWithWarning'
      flash[:notice] = 'Could not retrieve order information from PayPal'
      redirect_to :action => 'index' and return
    end

    payerInfo = res.getExpressCheckoutDetailsResponseDetails.payerInfo
    @order.paypal_payer_id = params['PayerID']
    @order.email = String.new(payerInfo.payer)
    @order.first_name = String.new(payerInfo.payerName.firstName)
    @order.last_name = String.new(payerInfo.payerName.lastName)
    @order.licensee_name = @order.first_name + " " + @order.last_name
    if payerInfo.respond_to? 'payerCountry'
      @order.country = String.new(payerInfo.payerCountry)
    else
      @order.country = 'XX'
    end
    @order.payment_type = 'PayPal'
    session[:order] = @order
  end

  def purchase_paypal
    render :action => 'no_order', :layout => 'error' and return if session[:order] == nil

    @order = session[:order]
    @order.attributes = params[:order]

    redirect_to :action => 'index' and return if @order.paypal_token == nil
    render :action => 'failed', :layout => 'error' and return if @order.status != 'P'

    @order.order_time = Time.now()

    if not @order.save()
      flash[:error] = 'Please fill out all fields'
      render :action => 'confirm_paypal' and return
    end

    success = @order.paypal_express_checkout_payment()

    finish_order(success)
  end

  ## Methods that need a completed order
  before_filter :check_completed_order, :only => [:thankyou, :receipt]

  def thankyou
    # no need to check for nil order in the session here.
    # check_completed_order is a before_filter for this method
    @order = session[:order]
  end

  def receipt
    # no need to check for nil order in the session here.
    # check_completed_order is a before_filter for this method
    @order = session[:order]
    @print = true
    render :partial => 'receipt'
  end

  ## Private methods
  private
  def check_completed_order
    unless session[:order] && session[:order].complete?
      redirect_to :action => "index"
    end
  end

  private
  def finish_order(success)
    if params[:subscribe] && params[:subscribe] == 'checked'
      @order.subscribe_to_list()
    end

    @order.status = success ? 'C' : 'F'
    @order.finish_and_save()

    if success
      session[:order] = @order
      redirect_to :action => 'thankyou'
    else
      render :action => 'failed', :layout => 'error'
    end
  end

end
