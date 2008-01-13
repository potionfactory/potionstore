# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  filter_parameter_logging "cc_number|cc_code|cc_month|cc_year"

  def check_authentication
    unless session[:logged_in]
      session[:intended_url] = request.request_uri
      logger.debug('intended_url: ' + session[:intended_url])
      redirect_to :controller => "/admin", :action => "login"
    end
  end
end

def is_live
  return ENV['RAILS_ENV'] == 'production'
end

# Load username and password for admin user
def load_store_prefs
  app_root = File.dirname(__FILE__) + '/../..'
  config_dir = app_root + '/config/'

  ymlpath = File.expand_path(config_dir + 'store.yml')
  $STORE_PREFS = YAML.load(File.open(ymlpath))
end

load_store_prefs()

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

  def _initialize_frontend
    environment = ENV['RAILS_ENV'] || 'production'

    app_root = File.dirname(__FILE__) + '/../..'
    config_dir = app_root + '/config'

    prefs = File.expand_path(config_dir + '/google_checkout.yml')
    if File.exists?(prefs)
      y = YAML.load(File.open(prefs))
      y.each {|pref, value| eval("@#{pref} =\"#{value}\"")}
      y[environment].each {|pref, value| eval("@#{pref} =\"#{value}\"")}
    end

    $GCHECKOUT_FRONTEND = Google4R::Checkout::Frontend.new(:merchant_id => @gcheckout_merchant_id,
                                                           :merchant_key => @gcheckout_merchant_key,
                                                           :use_sandbox => !is_live())

    $GCHECKOUT_FRONTEND.tax_table_factory = TaxTableFactory.new
  end


  _initialize_frontend()
end


# Make the debugger available in development
require 'ruby-debug' if not is_live()

