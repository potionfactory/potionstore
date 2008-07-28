require File.expand_path('lib/json_request', File.dirname(__FILE__))

ActionController::Base.class_eval do
  include ActionController::JsonRequest
end
