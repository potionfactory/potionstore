# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
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


# Make the debugger available in development
require 'ruby-debug' if not is_live()
