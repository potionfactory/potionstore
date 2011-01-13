
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
    session[:order_id] = nil
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
    session[:order_id] = nil
    redirect_to :action => 'index' and return if !params[:items]
    @order = Order.new
    @order.payment_type = params[:payment_type]
    session[:payment_type] = params[:payment_type]

    session[:items] = params[:items]

    if not @order.add_form_items(params[:items])
      flash[:notice] = 'Nothing to buy!'
      redirect_to :action => 'index' and return
    end

    coupon_text = params[:coupon].strip
    @order.coupon_text = coupon_text

    if !coupon_text.blank? && @order.coupon == nil
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

    if params[:payment_type] == 'paypal'
      # Handle Paypal orders
      res = @order.paypal_set_express_checkout(url_for(:action => 'confirm_paypal'), url_for(:action => 'index'))

      if res.ack == 'Success' || res.ack == 'SuccessWithWarning'
        # Need to copy the string. For some reason, it tries to render the payment action otherwise
        session[:paypal_token] = String.new(res.token)
        if not @order.save()
          flash[:notice] = 'Problem saving order'
          redirect_to :action => 'index' and return
        end
        session[:order_id] = @order.id
        redirect_to PayPal.express_checkout_redirect_url(res.token)
      else
        flash[:notice] = 'Could not connect to PayPal'
        redirect_to :action => 'index'
      end
    elsif params[:payment_type] == 'gcheckout'
      # Handle Google Checkout orders
      render :action => 'payment_gcheckout'
    else
      # credit card order
      # put in a dummy credit card number for testing
      @order.cc_number = '4916306176169494' if not is_live?()

      render :action => 'payment_cc'
    end
  end

  def redirect
    redirect_to :action => 'index'
  end

  # Accept orders from Cocoa storefront. It only works with JSON right now
  def create
    if params[:order] == nil
      respond_to do |format|
        format.json { render :json => '["Did not receive order"]', :status => :unprocessable_entity and return }
      end
    end

    # If there's a completed order in the session, just return that instead of charging twice
    if session[:order_id] != nil
      @order = Order.find(session[:order_id])
      if @order != nil && @order.status == 'C'
        respond_to do |format|
          format.json { render :json => @order.to_json(:include => [:line_items]) }
        end
        return
      end
    end

    @order = Order.new(params[:order])

    if not @order.save()
      respond_to do |format|
        format.json { render :json => @order.errors.full_messages.to_json, :status => :unprocessable_entity }
      end
      return
    end

    session[:order_id] = @order.id

    # Actually send out the payload
    if @order.cc_order?
      success = @order.paypal_direct_payment(request)
      @order.status = success ? 'C' : 'F'
      @order.finish_and_save() if success

      respond_to do |format|
        if success
          format.json { render :json => @order.to_json(:include => [:line_items]) }
        else
          format.json { render :json => @order.errors.full_messages.to_json, :status => :unprocessable_entity }
        end
      end
    end
  end

  def purchase
    redirect_to :action => 'index' and return unless params[:order] && params[:items]

    @order = ThehitlistOrder.find_by_unique_id(params[:order][:unique_id])

    if @order
      if @order.status == 'C'
        session[:order_id] = @order.id
        redirect_to :action => 'thankyou'
      elsif @order.status == 'S'
        # If the order was already submitted, wait half a second and call purchase again.
        # Hopefully it'll complete and we can be redirected to the thank you page
        sleep 0.5
        self.purchase
      else
        render :action => 'failed', :layout => 'error'
      end
      return
    end

    # We need the next two ugly lines because Safari's form autofill sucks
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
    @order.status = 'S'

    if not @order.save()
      flash[:error] = 'Please fill out all fields'
      if @order.cc_order?
        render :action => 'payment_cc' and return
      else
        render :action => 'payment_gcheckout' and return
      end
    end

    # Do this after saving order
    session[:order_id] = @order.id
    session[:items] = nil

    # Actually send out the payload
    if @order.cc_order?
      success = @order.paypal_direct_payment(request)
      finish_order(success)
    else
      # Google Checkout order
      redirect_url = @order.gcheckout_send_order(url_for(:action => 'index'))
      if redirect_url == nil
        @order.failure_reason = 'Could not connect to Google Checkout'
        render :action => 'failed', :layout => 'error' and return
      end
      redirect_to redirect_url and return
    end
  end

  def confirm_paypal
    render :action => 'no_order', :layout => 'error' and return if session[:order_id] == nil

    @order = Order.find(session[:order_id])
    redirect_to :action => 'index' and return if @order == nil || session[:paypal_token] != params[:token]

    # Suck the info from PayPal
    if not @order.update_from_paypal_express_checkout_details(session[:paypal_token])
      flash[:notice] = 'Could not retrieve order information from PayPal'
      redirect_to :action => 'index' and return
    end

    session[:paypal_payer_id] = params['PayerID']
    @order.payment_type = 'PayPal'

    if not @order.save()
      flash[:error] = 'Problem saving order'
      render :action => 'confirm_paypal' and return
    end

    session[:order_id] = @order.id
  end

  def purchase_paypal
    render :action => 'no_order', :layout => 'error' and return if session[:order_id] == nil

    @order = Order.find(session[:order_id])
    @order.attributes = params[:order]

    redirect_to :action => 'index' and return if session[:paypal_token] == nil
    render :action => 'failed', :layout => 'error' and return if !@order.pending?

    @order.order_time = Time.now()
    @order.status = 'S'

    if not @order.save()
      flash[:error] = 'Please fill out all fields'
      render :action => 'confirm_paypal' and return
    end

    success = @order.paypal_express_checkout_payment(session[:paypal_token], session[:paypal_payer_id])

    finish_order(success)
  end

  ## Methods that need a completed order
  before_filter :check_completed_order, :only => [:thankyou, :receipt]

  def thankyou
    # no need to check for nil order in the session here.
    # check_completed_order is a before_filter for this method
    @order = Order.find(session[:order_id])
  end

  def receipt
    # no need to check for nil order in the session here.
    # check_completed_order is a before_filter for this method
    @order = Order.find(session[:order_id])
    @print = true
    render :partial => 'receipt'
  end

  ## Private methods
  private
  def check_completed_order
    @order = Order.find(session[:order_id])
    unless @order && @order.complete?
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
      session[:order_id] = @order.id
      redirect_to :action => 'thankyou'
    else
      render :action => 'failed', :layout => 'error'
    end
  end

end
