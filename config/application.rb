require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Potionstore
  class Application < Rails::Application
    # Settings in config/environments/* take precedence those specified here
  
    # Skip frameworks you're not going to use
    # config.frameworks -= [ :action_web_service, :action_mailer ]
    #config.frameworks -= [ :action_web_service ]
  
    # Add additional load paths for your own custom dirs
    # config.autoload_paths += %W( #{RAILS_ROOT}/extras )
  
    # Force all environments to use the same logger level
    # (by default production uses :info, the others :debug)
    # config.log_level = :debug
  
    # Use the database for sessions instead of the file system
    # (create the session table with 'rake db:sessions:create')
    # config.action_controller.session_store = :active_record_store
  
    # If wanting Rails 2 with cookie store:
    #config.action_controller.session = { :key => "_potion_store_session", :secret => "sdaf0022s94hfdbz32sdjfhf4j-=123sdh" }
  
    # Use SQL instead of Active Record's schema dumper when creating the test database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql
  
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector
  
    # Make Active Record use UTC-base instead of local time
    # config.active_record.default_timezone = :utc
  
    # See Rails::Configuration for more options
  
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :cc_number, :cc_code, :cc_month, :cc_year]
  end
end