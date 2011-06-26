class Admin::OrdersController < ApplicationController

  layout "admin"

  before_filter :redirect_to_ssl, :check_authentication

  # GET /orders
  # GET /orders.xml
  def index
    q = params[:query]
    conditions = "status <> 'P'"
    if q
      q = q.strip().downcase()
      if q =~ /^\d+$/
        conditions = [conditions + " AND id=?", q.to_i]

      elsif q =~ /^\s*(.*?)\s*<\s*(.*?)\s*>.*$/
        # Parse email address pasted in the format of "John Doh <john.doh@me.com>"
        # and search by name and email address
        name = $1
        email = $2
        fname, lname = name.split(/\s+/, 2)
        lname = 'BLANK_LAST_NAME' if not lname # Just a dummy value to stop matching on last name
        conditions = [conditions + " AND ((LOWER(first_name) LIKE ? AND LOWER(last_name) LIKE ?) OR
                                           LOWER(licensee_name) = ? OR
                                           LOWER(email) = ?)",
                      "#{fname}%", "#{lname}%", name, email]
      else
        conditions = [conditions + " AND (LOWER(email) LIKE ? OR
                                          LOWER(first_name) LIKE ? OR
                                          LOWER(last_name) LIKE ? OR
                                          LOWER(licensee_name) LIKE ? OR
                                          ? IN (SELECT lower(license_key) FROM line_items WHERE order_id=orders.id))",
                      "#{q}%", "#{q}%", "#{q}%", "%#{q}%", q]
      end
    end
    @orders = Order.paginate :page => (params[:page] || 1), :per_page => 100, :conditions => conditions, :order => 'order_time DESC'

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @orders.to_xml }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @order.to_xml }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.country = 'US'
    @order.payment_type = 'Free'
  end

  # GET /orders/1;edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @order.status = 'C'

    respond_to do |format|
      if save()
        flash[:notice] = 'Order was successfully created.'
        format.html { redirect_to admin_order_url(@order) }
        format.xml  { head :created, :location => admin_order_url(@order) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors.to_xml }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:order][:id])

    # Delete the id from the form or ActiveRecord complains about changing it
    params[:order].delete(:id)

    @order.attributes = params[:order]

    if not save()
      redirect_to :back and return
    end

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to admin_order_url(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors.to_xml }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.xml  { head :ok }
    end
  end

  # GET /orders/1/cancel
  def cancel
    @order = Order.find(params[:id])
    @order.status = 'X'
    @order.save
    redirect_to :action => 'show', :id => @order.id
  end

  # GET /orders/1/uncancel
  def uncancel
    @order = Order.find(params[:id])
    @order.status = 'C'
    @order.save
    redirect_to :action => 'show', :id => @order.id
  end

  # GET /orders/1/refund
  def refund
    @order = Order.find(params[:id])
    @order.refund
    redirect_to :action => 'show', :id => @order.id
  end

  # GET /orders/1/send_emails
  def send_emails
    @order = Order.find(params[:id])
    OrderMailer.deliver_thankyou(@order)
    redirect_to :action => 'show', :id => @order.id
  end

  protected
  def save
    begin
      @order.transaction do
        if not @order.add_or_update_items(params[:items])
          flash[:notice] = 'Order contains no items'
          logger.warn('Order contains no items')
          return false
        end
        @order.update_item_prices(params[:item_prices])
        @order.skip_cc_validation = true

        if not @order.save()
          flash[:notice] = 'Could not save order'
          logger.error("ERROR -- Could not save order: #{@order.errors}")
          return false
        end
        return true
      end
    rescue Exception => e
      logger.error("ERROR -- Problem saving order: #{e}")
      return false
    end
  end
end
