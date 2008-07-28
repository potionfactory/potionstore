module ActionController
  # Handles JSON requests.
  module JsonRequest
    def self.included(mod)
      mod.param_parsers[Mime::JSON] = lambda { |body| { :_json => ActiveSupport::JSON.decode(body) }.with_indifferent_access }
      mod.extend ClassMethods
      mod.json_request
    end

  private

    def rename_json_params(name = nil) #:nodoc:
      if data = params.delete(:_json)
        name ||= controller_name
        name = name.to_s.singularize unless data.is_a?(Array)
        params.update(name=>data)
      end
    end

    module ClassMethods

      # Use this to handle JSON requests.  Adds a MIME handler for requests with the content type +application/json+,
      # and maps an incoming request to the proper parameter.
      #
      # All controllers inherit this bahavior using the controller name to determine the parameter name.  For example,
      # the ItemsController will store the JSON request in the parameter 'item'.
      #
      # You can also configure this as a filter and specify a specific parameter name, for example:
      #   class FooController < ActionController::Base
      #     json_request :bar, :only=>[:update]
      #   end
      def json_request(*args)
        options = args.extract_options!
        prepend_before_filter(options) { |controller| controller.send :rename_json_params, args.first }
      end

    end
  end
end 

