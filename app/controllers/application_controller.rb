# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Don't log any credit card data
  filter_parameter_logging :password, :cc_number, :cc_code, :cc_month, :cc_year

  def check_authentication
    unless session[:logged_in]
      session[:intended_url] = request.request_uri
      logger.debug('intended_url: ' + session[:intended_url])
      redirect_to :controller => "/admin", :action => "login"
    end
  end

  def redirect_to_ssl
    if is_live?() && $STORE_PREFS['redirect_to_ssl']
      redirect_to :protocol => "https://" unless (request.ssl? or local_request?)
    end
  end

end


# Convenience global function to check if we're running in production mode
def is_live?
  return ENV['RAILS_ENV'] == 'production'
end


# Load store preferences
def load_store_prefs
  app_root = File.dirname(__FILE__) + '/../..'
  config_dir = app_root + '/config/'

  ymlpath = File.expand_path(config_dir + 'store.yml')
  $STORE_PREFS = YAML.load(File.open(ymlpath))
end

load_store_prefs()


# Convenience global function for rounding to monetary amount
def round_money(amount)
  return ("%01.2f" % amount).to_f()
end


# Setup Google Checkout if it's in use
if $STORE_PREFS['allow_google_checkout']

  require 'google4r/checkout'

  $GCHECKOUT_FRONTEND = nil

  class TaxTableFactory
    def effective_tax_tables_at(time)

      tax_free_table = Google4R::Checkout::TaxTable.new(false)
      tax_free_table.name = "default table"
      tax_free_table.create_rule do |rule|
        rule.area = Google4R::Checkout::UsCountryArea.new(Google4R::Checkout::UsCountryArea::ALL)
        rule.rate = 0.0
      end
      return [tax_free_table]
    end
  end

  def _initialize_google_checkout
    environment = ENV['RAILS_ENV'] || 'production'

    app_root = File.dirname(__FILE__) + '/../..'
    config_dir = app_root + '/config'

    prefs = File.expand_path(config_dir + '/google_checkout.yml')
    if File.exists?(prefs)
      y = YAML.load(File.open(prefs))[environment]

      # Save the merchant id and key. It gets used in notification_controller for authenticating Google's notifications
      $STORE_PREFS['gcheckout_merchant_id'] = y['gcheckout_merchant_id']
      $STORE_PREFS['gcheckout_merchant_key'] = y['gcheckout_merchant_key']

      $GCHECKOUT_FRONTEND = Google4R::Checkout::Frontend.new(:merchant_id => y['gcheckout_merchant_id'],
                                                             :merchant_key => y['gcheckout_merchant_key'],
                                                             :use_sandbox => !is_live?())

      $GCHECKOUT_FRONTEND.tax_table_factory = TaxTableFactory.new
    else
      logger.error("Could not load Google Checkout configuration even though it's enabled")
    end
  end

  # Go ahead and call the Google Checkout initialization function
  _initialize_google_checkout()

end
