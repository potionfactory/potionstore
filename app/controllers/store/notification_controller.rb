require 'base64'

def _xmlval(hash, key)
  if hash[key] == {}
    nil
  else
    hash[key]
  end
end


class Store::NotificationController < ApplicationController

  ## Google Checkout notification

  def gcheckout
    # Check HTTP basic authentication first
    my_auth_key = Base64.encode64($STORE_PREFS['gcheckout_merchant_id'] + ':' + $STORE_PREFS['gcheckout_merchant_key']).strip()
    http_auth = request.headers['HTTP_AUTHORIZATION']
    if http_auth.nil? || http_auth.split(' ')[0] != 'Basic' || http_auth.split(' ')[1] != my_auth_key then
      logger.warn('Got unauthorized Google Checkout notification')
      render :text => 'Unauthorized', :status => 401 and return
    end

    # Authenticated. Parse the xml now
    notification = XmlSimple.xml_in(request.raw_post, 'KeepRoot' => true, 'ForceArray' => false)

    notification_name = notification.keys[0]
    notification_data = notification[notification_name]

    case notification_name
    when 'new-order-notification'
      process_new_order_notification(notification_data)

    when 'charge-amount-notification'
      process_charge_amount_notification(notification_data)
    # Ignore the other notifications
#   when 'order-state-change-notification'
#   when 'risk-information-notification'
    end

    render :text => ''
  end

  private
  def process_new_order_notification(n)
    order = Order.find(Integer(n['shopping-cart']['merchant-private-data']['order-id']))

    return if order == nil or order.payment_type != 'Google Checkout'

    ba = n['buyer-billing-address']

    if ba['structured-name']
      order.first_name = _xmlval(ba['structured-name'], 'first-name')
      order.last_name = _xmlval(ba['structured-name'], 'last-name')
    else
      words = ba['contact-name'].split(' ')
      order.first_name = words.shift
      order.last_name = words.join(' ')
    end

    order.email = _xmlval(ba, 'email')
    if order.email == nil # This shouldn't happen, but just in case
      order.status = 'F'
      order.failure_reason = 'Did not get email from Google Checkout'
      order.finish_and_save()
      return
    end

    order.address1 = _xmlval(ba, 'address1')
    order.address2 = _xmlval(ba, 'address2')
    order.city     = _xmlval(ba, 'city')
    order.company  = _xmlval(ba, 'company-name')
    order.country  = _xmlval(ba, 'country-code')
    order.zipcode  = _xmlval(ba, 'postal-code')
    order.state    = _xmlval(ba, 'region')

    order.transaction_number = n['google-order-number']

    order.save()

    order.subscribe_to_list() if n['buyer-marketing-preferences']['email_allowed'] == 'true'

    order.send_to_google_add_merchant_order_number_command()
  end

  private
  def process_charge_amount_notification(n)
    order = Order.find_by_transaction_number_and_payment_type(n['google-order-number'], 'Google Checkout')

    return if order == nil or order.status == 'C'

    order.status = 'C'
    order.finish_and_save()
    OrderMailer.deliver_thankyou(order) if is_live?()

    order.send_to_google_archive_order_command()
  end

end
