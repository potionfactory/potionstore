class Admin::CouponsController < ApplicationController
  layout "admin"
  before_filter :check_authentication

  def index
    @coupons = Coupon.group(:code).count(:code)
  end

  def show
    @coupons = Coupon.where(:code => params[:id])
  end
  
  def new
    @coupon = Coupon.new
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end
  
  def toggle_state
    @coupon = Coupon.find(params[:id])
    
    if params[:operation] == 'enable'
      @coupon.enabled = true
    elsif params[:operation] == 'disable'
      @coupon.enabled = false
    end
    
    if @coupon.save
      redirect_to admin_coupon_path(@coupon.code), notice: 'Coupon was successfully disabled.'
    else
      redirect_to admin_coupon_path(@coupon.code), notice: 'Unable to disable coupon.'
    end
  end
  
  def toggle_state_for_all_coupons_with_code
    @coupons = Coupon.where(:code => params[:id])
    @coupons.each do |coupon|
      if params[:operation] == 'enable'
        coupon.enabled = true
      elsif params[:operation] == 'disable'
        coupon.enabled = false
      end
      coupon.save
    end
    
    redirect_to admin_coupon_path(@coupons.first.code)
  end

=begin
  def delete_all_coupons_with_code
    @coupons = Coupon.where(:code => params[:id])
    @coupons.each do |coupon|
      coupon.delete
    end
    
    redirect_to admin_coupons_path
  end
=end

  def create
    if params[:coupon]
      form = params[:coupon]

      if Integer(form[:quantity]) == 1 && !form[:coupon].blank?
        generate_coupon(form[:code], form[:product_code], form[:description],
                        form[:amount], form[:use_limit], form[:coupon].gsub(/[^0-9a-z ]/i, '').upcase)
      else
        1.upto(Integer(form[:quantity])) { |i|
          generate_coupon(form[:code], form[:product_code], form[:description],
                          form[:amount], form[:use_limit], Coupon.random_string_of_length(16).upcase)
        }
      end

      flash[:notice] = 'Coupons generated'
    end
    
    redirect_to admin_coupons_path
  end

  def update
    @coupon = Coupon.find(params[:id])
    
    if @coupon.update_attributes(params[:coupon])
      redirect_to admin_coupons_path, notice: 'Coupon was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    redirect_to admin_coupons_url
  end
  
  private
    def generate_coupon(code, product_code, description, amount, use_limit, coupon_code)
      coupon = Coupon.new
      coupon.code = code
      coupon.product_code = product_code
      coupon.description = description
      coupon.amount = amount
      coupon.use_limit = use_limit
      coupon.coupon = coupon_code
      coupon.creation_time = Time.now
      coupon.save 
    end
end
