class Admin::OrdersController < ApplicationController

  layout "admin"

  before_filter :redirect_to_ssl, :check_authentication

  # GET /orders
  # GET /orders.xml
  def index
    q = params[:query]
    conditions = "status != 'P'"
    if q
      q = q.strip().downcase()
      if q.to_i != 0
        conditions = [conditions + "AND id=?", q.to_i]
      else
        conditions = [conditions + " AND (LOWER(email) LIKE ? OR
                                          LOWER(first_name) LIKE ? OR
                                          LOWER(last_name) LIKE ? OR
                                          LOWER(licensee_name) LIKE ?)", "#{q}%", "#{q}%", "#{q}%", "%#{q}%"]
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
        format.html { redirect_to order_url(@order) }
        format.xml  { head :created, :location => order_url(@order) }
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
        format.html { redirect_to order_url(@order) }
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

  def cancel
    @order = Order.find(params[:id])
    @order.status = 'X'
    @order.save
    redirect_to :action => 'show', :id => @order.id
  end

  def uncancel
    @order = Order.find(params[:id])
    @order.status = 'C'
    @order.save
    redirect_to :action => 'show', :id => @order.id
  end

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
