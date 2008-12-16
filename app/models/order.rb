COUNTRY_MAPPING = {
  "US" => "United States", "AL" => "Albania", "DZ" => "Algeria", "AD" => "Andorra", "AO" => "Angola",
  "AI" => "Anguilla", "AG" => "Antigua and Barbuda", "AR" => "Argentina", "AM" => "Armenia",
  "AW" => "Aruba", "AU" => "Australia", "AT" => "Austria", "AZ" => "Azerbaijan Republic",
  "BS" => "Bahamas", "BH" => "Bahrain", "BB" => "Barbados", "BE" => "Belgium", "BZ" => "Belize",
  "BJ" => "Benin", "BM" => "Bermuda", "BT" => "Bhutan", "BO" => "Bolivia",
  "BA" => "Bosnia and Herzegovina", "BW" => "Botswana", "BR" => "Brazil",
  "VG" => "British Virgin Islands", "BN" => "Brunei", "BG" => "Bulgaria", "BF" => "Burkina Faso",
  "BI" => "Burundi", "KH" => "Cambodia", "CA" => "Canada", "CV" => "Cape Verde",
  "KY" => "Cayman Islands", "TD" => "Chad", "CL" => "Chile", "C2" => "China", "CO" => "Colombia",
  "KM" => "Comoros", "CK" => "Cook Islands", "CR" => "Costa Rica", "HR" => "Croatia",
  "CY" => "Cyprus", "CZ" => "Czech Republic", "CD" => "Democratic Republic of the Congo",
  "DK" => "Denmark", "DJ" => "Djibouti", "DM" => "Dominica", "DO" => "Dominican Republic",
  "EC" => "Ecuador", "SV" => "El Salvador", "ER" => "Eritrea", "EE" => "Estonia", "ET" => "Ethiopia",
  "FK" => "Falkland Islands", "FO" => "Faroe Islands", "FM" => "Federated States of Micronesia",
  "FJ" => "Fiji", "FI" => "Finland", "FR" => "France", "GF" => "French Guiana",
  "PF" => "French Polynesia", "GA" => "Gabon Republic", "GM" => "Gambia", "DE" => "Germany",
  "GI" => "Gibraltar", "GR" => "Greece", "GL" => "Greenland", "GD" => "Grenada",
  "GP" => "Guadeloupe", "GT" => "Guatemala", "GN" => "Guinea", "GW" => "Guinea Bissau",
  "GY" => "Guyana", "HN" => "Honduras", "HK" => "Hong Kong", "HU" => "Hungary", "IS" => "Iceland",
  "IN" => "India", "ID" => "Indonesia", "IE" => "Ireland", "IL" => "Israel", "IT" => "Italy",
  "JM" => "Jamaica", "JP" => "Japan", "JO" => "Jordan", "KZ" => "Kazakhstan", "KE" => "Kenya",
  "KI" => "Kiribati", "KW" => "Kuwait", "KG" => "Kyrgyzstan", "LA" => "Laos", "LV" => "Latvia",
  "LS" => "Lesotho", "LI" => "Liechtenstein", "LT" => "Lithuania", "LU" => "Luxembourg",
  "MG" => "Madagascar", "MW" => "Malawi", "MY" => "Malaysia", "MV" => "Maldives", "ML" => "Mali",
  "MT" => "Malta", "MH" => "Marshall Islands", "MQ" => "Martinique", "MR" => "Mauritania",
  "MU" => "Mauritius", "YT" => "Mayotte", "MX" => "Mexico", "MN" => "Mongolia", "MS" => "Montserrat",
  "MA" => "Morocco", "MZ" => "Mozambique", "NA" => "Namibia", "NR" => "Nauru", "NP" => "Nepal",
  "NL" => "Netherlands", "AN" => "Netherlands Antilles", "NC" => "New Caledonia",
  "NZ" => "New Zealand", "NI" => "Nicaragua", "NE" => "Niger", "NU" => "Niue",
  "NF" => "Norfolk Island", "NO" => "Norway", "OM" => "Oman", "PW" => "Palau", "PA" => "Panama",
  "PG" => "Papua New Guinea", "PE" => "Peru", "PH" => "Philippines", "PN" => "Pitcairn Islands",
  "PL" => "Poland", "PT" => "Portugal", "QA" => "Qatar", "CG" => "Republic of the Congo",
  "RE" => "Reunion", "RO" => "Romania", "RU" => "Russia", "RW" => "Rwanda",
  "VC" => "Saint Vincent and the Grenadines", "WS" => "Samoa", "SM" => "San Marino",
  "ST" => "São Tomé and Príncipe", "SA" => "Saudi Arabia", "SN" => "Senegal", "SC" => "Seychelles",
  "SL" => "Sierra Leone", "SG" => "Singapore", "SK" => "Slovakia", "SI" => "Slovenia",
  "SB" => "Solomon Islands", "SO" => "Somalia", "ZA" => "South Africa", "KR" => "South Korea",
  "ES" => "Spain", "LK" => "Sri Lanka", "SH" => "St. Helena", "KN" => "St. Kitts and Nevis",
  "LC" => "St. Lucia", "PM" => "St. Pierre and Miquelon", "SR" => "Suriname",
  "SJ" => "Svalbard and Jan Mayen Islands", "SZ" => "Swaziland", "SE" => "Sweden",
  "CH" => "Switzerland", "TW" => "Taiwan", "TJ" => "Tajikistan", "TZ" => "Tanzania",
  "TH" => "Thailand", "TG" => "Togo", "TO" => "Tonga", "TT" => "Trinidad and Tobago",
  "TN" => "Tunisia", "TR" => "Turkey", "TM" => "Turkmenistan", "TC" => "Turks and Caicos Islands",
  "TV" => "Tuvalu", "UG" => "Uganda", "UA" => "Ukraine", "AE" => "United Arab Emirates",
  "GB" => "United Kingdom", "UY" => "Uruguay", "VU" => "Vanuatu", "VA" => "Vatican City State",
  "VE" => "Venezuela", "VN" => "Vietnam", "WF" => "Wallis and Futuna Islands", "YE" => "Yemen",
  "ZM" => "Zambia"
}


class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :coupon

  attr_accessor :cc_code, :cc_month, :cc_year
  attr_accessor :paypal_token, :paypal_payer_id
  attr_accessor :skip_cc_validation
  attr_writer :promo_coupons

  validates_presence_of :payment_type

  def validate
    ## Validate credit card order
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

    ## Validate PayPal order
    if self.paypal_order?
      errors.add_on_blank(['email'])
    end

    ## If licensee name is all alpha-numeric, require it to be at least 8 characters.
    if self.licensee_name == nil || self.licensee_name.strip == ''
      errors.add_on_blank(['licensee_name'])
    elsif (self.licensee_name =~ /^[\w ]*$/) != nil && self.licensee_name.length < 8
      errors.add('licensee_name', msg= 'must be at least 8 characters long')
    end
  end

  def total
    return round_money(total_before_applying_coupons() - coupon_amount())
  end

  def total_before_applying_coupons
    total = 0
    for item in self.line_items
        total = total + item.total
    end
    return round_money(total)
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
        return round_money(item.total * coupon.percentage / 100.0)
      end
    end
    if coupon && coupon.percentage != nil && coupon.product_code == 'all'
      return round_money(total_before_applying_coupons() * (coupon.percentage / 100.0))
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
    write_attribute(:licensee_name, new_name.strip())
    if regenerate_keys
      for item in self.line_items
        item.license_key = item.generate_license_key
      end
    end
  end

  def country_name
    return COUNTRY_MAPPING[self.country]
  end

  def first_name=(value)
    write_attribute(:first_name, value.strip())
  end

  def last_name=(value)
    write_attribute(:last_name, value.strip())
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

  def payment_type=(type)
    val = type
    if type
      if ['visa', 'amex', 'discover'].member?(type.downcase())
        val = type.capitalize()
      elsif type.downcase() == 'mastercard'
        val = 'MasterCard'
      end
    end
    write_attribute(:payment_type, val)
  end

  def cc_order?
    return ['visa', 'mastercard', 'amex', 'discover'].member?(self.payment_type.downcase)
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
        next if items[product_id].to_s.strip == ''
        item = LineItem.new
        item.order = self
        item.product_id = product_id
        item.quantity = items[product_id]
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
      logger.error("Could not add form product items: #{$!}")
      return false
    end
  end

  def add_or_update_items(items)
    for product_id in items.keys
      next if items[product_id].to_s.strip == ''
      litem = self.line_item_with_product_id(product_id)
      if litem == nil
        return false if not self.add_form_items({product_id => items[product_id]})
      else
        quantity = items[product_id].to_i
        if quantity <= 0
          litem.destroy()
          self.line_items.delete(litem)
        else
          litem.quantity = quantity
        end
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
    return if ListSubscriber.find_by_email(self.email) != nil
    subscriber = ListSubscriber.new
    subscriber.email = self.email
    subscriber.save()
  end

  def save
    # Insert a dash for Japanese zipcodes if it doesn't have one
    if self.country == 'JP' && self.zipcode != nil && self.zipcode.count('-') == 0 && self.zipcode.length > 3
      self.zipcode.insert(3, '-')
    end

    # Take out optional strings
    self.address2 = '' if self.address2 != nil && self.address2.strip == 'optional'
    self.company = '' if self.company != nil && self.company.strip == 'optional'
    self.comment = '' if self.comment != nil && self.comment.strip == 'optional'

    # Save updated relationships
    for item in self.line_items
      if !item.new_record? && item.changed?
        item.save()
      end
    end

    if self.coupon != nil && !self.coupon.new_record? && self.coupon.changed?
      self.coupon.save()
    end

    super()
  end

  def finish_and_save
    if self.status == 'C'
      self.add_promo_coupons()
      for line_item in self.line_items
        if line_item.license_key.nil? then
          line_item.license_key = line_item.generate_license_key()
        end
      end
      if self.coupon
        self.coupon.used_count += 1
      end
    end

    self.save()
  end


  # PayPal related methods
  def paypal_directcharge(request)
    # The following is needed because MediaTemple puts in two ip addresses in REMOTE_ADDR for some reason
    ip_address = request.env['REMOTE_ADDR']
    ip_address = ip_address.split(',')[0] if ip_address.count(",") != 0
    ip_address = "127.0.0.1" if ip_address == "::1"

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
    success = (res.ack == 'Success' || res.ack == 'SuccessWithWarning')
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
    success = (res.ack == 'Success' || res.ack == 'SuccessWithWarning')
    if success
      self.transaction_number = res.doExpressCheckoutPaymentResponseDetails.paymentInfo.transactionID
    else
      set_order_errors_with_paypal_response(res)
    end
    return success
  end

  def set_order_errors_with_paypal_response(res)
    if res.ack == 'Failure' || res.ack == 'FailureWithWarning'
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

      # The 127 limit comes from the schema.
      # TODO: figure out a way to get the limit from the db schema
      if self.failure_reason.length > 127
        self.failure_reason = self.failure_reason[0...127]
      end
    end
  end


  # Google Checkout related methods
  def send_to_google_checkout(edit_cart_url = nil)
    command = $GCHECKOUT_FRONTEND.create_checkout_command
    command.continue_shopping_url = $STORE_PREFS['company_url']
    command.edit_cart_url = edit_cart_url

    for line_item in self.line_items
      command.shopping_cart.create_item do |item|
        item.name = line_item.product.name
        item.description = ""
        item.unit_price = Money.new(line_item.unit_price * 100)
        item.quantity = line_item.quantity

        # Force a license key generation here even though the order status is still P.
        # The order doesn't become status C until we get final notification from Google,
        # but we're still optimistically showing the buyer their license key because otherwise
        # the delay can be as much as 20 minutes on the GCheckout side
        line_item.license_key = line_item.generate_license_key()
        line_item.save()

        digital_content = Google4R::Checkout::DigitalContent.new
        digital_content.key = line_item.license_key
        digital_content.description = "#{line_item.product.name}, licensed to #{self.licensee_name}"
        digital_content.display_disposition = 'OPTIMISTIC'

        # NOTE: If you don't like the way the license key is presented on Google Checkout after
        # the buyer completes the purchase, you can also not set the digital_content.key and
        # format everything with digital_content.description. You can even put HTML in there.

        item.digital_content = digital_content
      end
    end

    if self.coupon
      command.shopping_cart.create_item do |item|
        item.name = "Coupon"
        item.description = coupon.description
        item.unit_price = Money.new(-coupon_amount() * 100)
        item.quantity = 1
      end
    end

    command.shopping_cart.private_data = { 'order-id' => [self.id] }

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

