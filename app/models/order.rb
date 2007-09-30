COUNTRY_MAPPING = {
  'AI' => 'Anguilla', 'AR' => 'Argentina', 'AU' => 'Australia', 'AT' => 'Austria', 'BE' => 'Belgium',
  'BR' => 'Brazil', 'CA' => 'Canada', 'CL' => 'Chile', 'CN' => 'China', 'CR' => 'Costa Rica', 'CY' => 'Cyprus',
  'CZ' => 'Czech Republic', 'DK' => 'Denmark', 'DO' => 'Dominican Republic', 'EC' => 'Ecuador', 'EE' => 'Estonia',
  'FI' => 'Finland', 'FR' => 'France', 'DE' => 'Germany', 'GR' => 'Greece', 'HK' => 'Hong Kong',
  'HU' => 'Hungary', 'IS' => 'Iceland', 'IN' => 'India', 'IE' => 'Ireland', 'IL' => 'Israel',
  'IT' => 'Italy', 'JM' => 'Jamaica', 'JP' => 'Japan', 'LV' => 'Latvia', 'LT' => 'Lithuania',
  'LU' => 'Luxembourg', 'MY' => 'Malaysia', 'MT' => 'Malta', 'MX' => 'Mexico', 'NL' => 'Netherlands',
  'NZ' => 'New Zealand', 'NO' => 'Norway', 'PL' => 'Poland', 'PT' => 'Portugal', 'SG' => 'Singapore',
  'SK' => 'Slovakia', 'SI' => 'Slovenia', 'ZA' => 'South Africa', 'KR' => 'South Korea', 'ES' => 'Spain',
  'SE' => 'Sweden', 'CH' => 'Switzerland', 'TW' => 'Taiwan', 'TH' => 'Thailand', 'TR' => 'Turkey',
  'GB' => 'United Kingdom', 'US' => 'United States', 'UY' => 'Uruguay', 'VE' => 'Venezuela'}

class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :coupon

  attr_accessor :cc_code, :cc_month, :cc_year
  attr_accessor :paypal_token, :paypal_payer_id
  attr_accessor :skip_cc_validation
  attr_writer :promo_coupons

  validates_presence_of :licensee_name, :payment_type

  def validate
    if self.cc_order? && !skip_cc_validation
      errors.add_on_blank(['first_name', 'last_name', 'address1', 'city', 'country', 'email'])
      if self.status == 'P'
        errors.add_on_blank(['cc_number', 'cc_month', 'cc_year', 'cc_code'])
      end

      if ['US', 'CA'].member?(self.country)
        errors.add_on_blank('zipcode')
        errors.add('state', msg = 'must be a 2 character abbreviation for USA and Canada') if self.state.size != 2
      end
    end
    
    if self.paypal_order?
      errors.add_on_blank(['email'])
    end
  end

  def total
    return total_before_applying_coupons() - coupon_amount()
  end

  def total_before_applying_coupons
    total = 0
    for item in self.line_items
        total = total + item.total
    end
    return total
  end

  ## tax and shipping are hard-wired to 0 for now
  def tax_total
    return 0
  end

  def shipping_total
    return 0
  end

  def coupon_amount
    return 0 if coupon == nil
    return coupon.amount if coupon.percentage == nil
    for item in self.line_items
      if coupon && coupon.percentage != nil && coupon.product_code == item.product.code
        return (item.total * coupon.percentage / 100.0)
      end
    end
    if coupon && coupon.percentage != nil && coupon.product_code == 'all'
      return total_before_applying_coupons() * (coupon.percentage / 100.0)
    end
    return 0
  end    

  def volume_discount_total
    total = self.total()
    self.line_items.collect{|x| x.regular_price * x.quantity}.each {|x| total -= x}
    return -total
  end

  def items_count
    return self.line_items.reject{|x| x.quantity <= 0}.length
  end

  def product_quantity(product_code)
    for item in self.line_items
      return item.quantity if item.product.code == product_code
    end
    return 0
  end

  def licensee_name=(new_name)
    regenerate_keys = (self.licensee_name != new_name)
    write_attribute(:licensee_name, new_name)
    if regenerate_keys
      for item in self.line_items
        item.license_key = item.generate_license_key
        item.save() if !item.new_record?
      end
    end
  end
  
  def country_name
    return COUNTRY_MAPPING[self.country]
  end

  def name
    return self.first_name + ' ' + self.last_name
  end

  def address
    address = self.address1
    address += ', ' + self.address2 if self.address2 != ''
    return address
  end

  def cc_number
    return @cc_number
  end

  def cc_number=(num)
    t = num.tr('- ', '')
    @cc_number = t
    return if t.length < 4
    self.ccnum = 'X' * (t.length - 4) + t[t.length-4 .. t.length-1]
  end

  def cc_order?
    return ['Visa', 'MasterCard', 'Amex', 'Discover'].member?(self.payment_type)
  end

  def paypal_order?
    return self.payment_type != nil && self.payment_type.downcase == 'paypal'
  end

  def gcheckout?
    return self.payment_type != nil && self.payment_type.downcase == 'google checkout'
  end

  def complete?
    return self.status == 'C'
  end

  def status_description
    case self.status
    when 'C'
      return 'Complete'
    when 'P'
      return 'Pending'
    when 'F'
      return 'Failed'
    when 'X'
      return 'Cancelled'
    end
    return self.status
  end

  def coupon_text
    self.coupon.coupon
  end

  def coupon_text=(coupon_text)
    return if !coupon_text || coupon_text.strip == ''
    coupon = Coupon.find_by_coupon(coupon_text.strip)
    if coupon != nil &&
        self.coupon == nil &&
        (coupon.product_code == 'all' || has_item_with_code(coupon.product_code)) &&
        !coupon.expired?
      self.coupon = coupon
    end
  end

  def has_item_with_product_id(product_id)
    return self.line_items.collect {|x| x.product.id if x.quantity > 0}.member?(product_id)
  end

  def has_item_with_code(code)
    return self.line_items.collect {|x| x.product.code if x.quantity > 0}.member?(code)
  end

  def line_item_with_product_id(product_id)
    begin
      product_id = Integer(product_id)
    rescue
      return nil
    end
    items = self.line_items.collect {|x| x if x.product.id == product_id}.compact
    return nil if items.length == 0
    return items[0]
  end

  def line_item_with_product_code(product_code)
    p = Product.find_by_code(product_code)
    return self.line_item_with_product_id(p.id)
  end

  # Add items from form parameters
  def add_form_items(items)
    begin
      for product_id in items.keys
        next if items[product_id].strip == ''
        item = LineItem.new
        item.order
        item.order = self
        item.product_id = product_id
        item.quantity = Integer(items[product_id])
        next if item.quantity == 0
        if item.quantity < 0
          return false
        end
        item.unit_price = Product.find(product_id).price
        self.line_items << item
      end
      for item in self.line_items
        item.unit_price = item.volume_price
      end
      return true
    rescue
      return false
    end
  end

  def add_or_update_items(items)
    for product_id in items.keys
      next if items[product_id].strip == ''
      litem = self.line_item_with_product_id(product_id)
      if litem == nil
        return false if not self.add_form_items({product_id => items[product_id]})
      else
        litem.quantity = Integer(items[product_id])
        litem.update
      end
    end
    return true
  end

  # Updates the prices from form
  def update_item_prices(item_prices)
    for product_id in item_prices.keys
      litem = self.line_item_with_product_id(product_id)
      next if litem == nil
      litem.unit_price = item_prices[product_id]
      litem.update
    end
  end

  def promo_coupons
    return @promo_coupons if @promo_coupons
    return []
  end
  
  # Create new coupons that pertain to this order and return it
  def add_promo_coupons
    self.promo_coupons = []
    # if the order contains Voice Candy, create 3 coupons
#     if self.has_item_with_code('vc')
#       1.upto(3) { |i|
#         coupon = Coupon.new
#         coupon.code = 'vc'
#         coupon.product_code = 'vc'
#         coupon.description = 'Cool friend discount'
#         coupon.amount = 3.00
#         coupon.numdays = 16
#         coupon.save()
#         coupons << coupon
#       }
#     end
    return promo_coupons
  end

  def subscribe_to_list
    ListSubscriber.find_by_email(self.email) == nil
    subscriber = ListSubscriber.new
    subscriber.email = self.email
    subscriber.save()
  end

  def finish_and_save
    if self.status == 'C'
      self.add_promo_coupons()
      self.status = 'C'
      for line_item in self.line_items
        line_item.license_key = line_item.generate_license_key()
        line_item.save()
      end
      if self.coupon
        self.coupon.used_count += 1
        self.coupon.save()
      end
    end

    self.save()
  end


  # PayPal related methods
  def paypal_directcharge(request)
    #    return true if not is_live()

    # The following is needed because MediaTemple puts in two ip addresses in the REMOTE_ADDR for some reason
    ip_address = request.env['REMOTE_ADDR']
    ip_address = ip_address.split(',')[0] if ip_address.count(",") != 0

    cc_year = self.cc_year.to_s
    if cc_year.length == 2
      cc_year = '20' + cc_year
    elsif cc_year.length == 1
      cc_year = '200' + cc_year
    end
    res = Paypal.directcharge(:firstName => self.first_name,
                              :lastName => self.last_name,
                              :ip => ip_address,
                              :amount => self.total,
                              :itemName => $STORE_PREFS['company_name'] + ' Software',
                              :addressName => 'Billing',
                              :street1 => self.address1,
                              :street2 => self.address2,
                              :cityName => self.city,
                              :stateOrProvince => (self.state.blank?) ? 'N/A' : self.state,
                              :postalCode => self.zipcode,
                              :country => self.country,
                              :creditCardType => self.payment_type,
                              :creditCardNumber => self.cc_number,
                              :cVV2 => self.cc_code,
                              :expMonth => self.cc_month,
                              :expYear => cc_year)
    success = (res.ack == 'Success')
    if success
      self.transaction_number = res.transactionID
    else
      set_order_errors_with_paypal_response(res)
    end
    return success
  end

  def paypal_express_checkout_payment()
    res = Paypal.express_checkout_payment(:token => self.paypal_token,
                                          :payerID => self.paypal_payer_id,
                                          :amount => self.total)
    success = (res.ack == 'Success')
    if success
      self.transaction_number = res.doExpressCheckoutPaymentResponseDetails.paymentInfo.transactionID
    else
      set_order_errors_with_paypal_response(res)
    end
    return success
  end

  def set_order_errors_with_paypal_response(res)
    if res.ack == 'Failure'
      self.failure_reason = ''
      if res.errors.respond_to? 'length'
        errors = res.errors
      else
        errors = [res.errors]
      end

      self.failure_code = errors.collect {|x| x.errorCode}.join(', ')

      self.failure_reason = errors.collect {|error|
        msg = ''
        if error.respond_to? 'longMessage'
          msg = error.longMessage
        elsif error.repond_to? 'shortMessage'
          msg = error.shortMessage
        end
        msg = msg[38..-1] if msg =~ /^This transaction cannot be processed. /
        msg
      }.join("\n")
      if res.respond_to? 'cVV2Code'
        self.failure_reason += "\nThe card security code did not match." if res.cVV2Code == 'N'
      end
    end
  end

  
  # Google Checkout related methods
  def send_to_google_checkout(edit_cart_url = nil)
    # TODO: move the hard coded data out to the configuration
    command = $GCHECKOUT_FRONTEND.create_checkout_command
    command.continue_shopping_url = $STORE_PREFS['company_url']
    command.edit_cart_url = edit_cart_url

    for line_item in self.line_items
      command.cart.create_item do |item|
        item.name = line_item.product.name
        item.description = ""
        item.unit_price = Money.new(line_item.unit_price * 100)
        item.quantity = line_item.quantity
      end
    end

    if self.coupon
      command.cart.create_item do |item|
        item.name = "Coupon"
        item.description = coupon.description
        item.unit_price = Money.new(-coupon_amount() * 100)
        item.quantity = 1
      end
    end

    command.cart.private_data = { 'order-id' => [self.id] }

    begin
      res = command.send_to_google_checkout()
      return res.redirect_url
    rescue
      logger.error("An error while talking to google checkout: #{$!}")
      return nil
    end
  end

  def send_to_google_add_merchant_order_number_command
    command = $GCHECKOUT_FRONTEND.create_add_merchant_order_number_command
    command.google_order_number = self.transaction_number
    command.merchant_order_number = self.id
    command.send_to_google_checkout() rescue nil
  end

  def send_to_google_deliver_order_command
    command = $GCHECKOUT_FRONTEND.create_deliver_order_command
    command.google_order_number = self.transaction_number
    command.send_email = false
    command.send_to_google_checkout() rescue nil
  end

  def send_to_google_archive_order_command
    command = $GCHECKOUT_FRONTEND.create_archive_order_command
    command.google_order_number = self.transaction_number
    command.send_to_google_checkout() rescue nil
  end
end

