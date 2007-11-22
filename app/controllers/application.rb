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

# Make the debugger available in development
require 'ruby-debug' if not is_live()
