class EmailController < ApplicationController
  def crash_report
    SupportMailer.deliver_crash_report(params["product"],
                                       params["crashlog"])
    render :text => ''
  end

  def support_request
  	SupportMailer.deliver_support_request(params)
    render :text => ''
  end
end
