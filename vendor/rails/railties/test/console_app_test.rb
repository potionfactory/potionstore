require 'abstract_unit'

require 'action_controller' # console_app uses 'action_controller/integration'

unless defined? ApplicationController
  class ApplicationController < ActionController::Base; end
  ActionController::Base.session_store = nil
end

require 'dispatcher'
require 'console_app'

# console_app sets Test::Unit.run to work around the at_exit hook in test/unit, which kills IRB
if Test::Unit.respond_to?(:run=)
  Test::Unit.run = false

  class ConsoleAppTest < Test::Unit::TestCase
    def test_app_method_should_return_integration_session
      assert_nothing_thrown do
        console_session = app
        assert_not_nil console_session
        assert_instance_of ActionController::Integration::Session,
          console_session
      end
    end

    def test_reload_should_fire_preparation_callbacks
      a = b = c = nil

      Dispatcher.to_prepare { a = b = c = 1 }
      Dispatcher.to_prepare { b = c = 2 }
      Dispatcher.to_prepare { c = 3 }
      ActionController::Routing::Routes.expects(:reload)

      reload!

      assert_equal 1, a
      assert_equal 2, b
      assert_equal 3, c
    end
  end
end
