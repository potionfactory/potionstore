class OrderMailer < ActionMailer::Base

  def thankyou(order, bcc = true)
    @order = order;
    mail(
      :to => order.email, 
      :subject => "Purchase Receipt for Order ##{order.id}", 
      :from => $STORE_PREFS['purchase_receipt_sender_email'],
      :bcc => bcc ? $STORE_PREFS['purchase_receipt_bcc_email'] : ""
      )  do |format|
        format.text  # comment out either one to test
        format.html
    end
  end

  def lost_license_sent(order)
    @order = order;
    mail(
      :to => $STORE_PREFS['lost_license_sent_notification_recipient_email'], 
      :subject => 'Lost License Sent', 
      :from => $STORE_PREFS['purchase_receipt_sender_email']
      ) do |format|
        format.text
    end
  end

end
