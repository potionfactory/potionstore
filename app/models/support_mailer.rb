class SupportMailer < ActionMailer::Base

  def support_request(fields)

    if fields["registered"] == "1"
      subject "#{fields["product"]} Support *"
    else
      subject "#{fields["product"]} Support"
    end
    recipients fields["recipient"]
    from       fields["replyTo"]

    email_body = fields["message"] + "\r\n\r\n"

    exclude_fields = ["product", "recipient", "replyTo", "message", "action", "controller"]

    fields.each do |key, value|
    	if fields[key].respond_to?("original_filename") == false && exclude_fields.include?(key) == false && fields[key] != nil
	    	email_body = email_body + fields[key]
    	end
    end
    email_body = email_body + "\r\n\r\n"

    body = {}
    part :content_type => "text/plain", :body => email_body

    fields.each do |key, value|
		if fields[key].respond_to?("original_filename") == true && exclude_fields.include?(key) == false && fields[key] != nil
		  attachment "application/binary" do |x|
			x.filename = fields[key].original_filename.gsub(/[^a-zA-Z0-9.]/, '_')
			x.body = fields[key].read
		  end
		end
	end
  end

  def crash_report(product, report)
    if is_live?()
      subject "#{product} Crash Report"
    else
      subject "#{product} Crash Report (this is a test)"
    end
    recipients $STORE_PREFS['crash_report_recipient_email']
    from	   $STORE_PREFS['crash_report_sender_email']

    body :report => report
  end

end
