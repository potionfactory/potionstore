$:.unshift File.expand_path('../../../rails', File.dirname(__FILE__))
require 'actionpack/test/abstract_unit'
require 'action_controller/integration'
$:.unshift File.expand_path('../lib', File.dirname(__FILE__))
require File.dirname(__FILE__) + '/../init'


class JsonRequestTest < Test::Unit::TestCase

  class ItemsController < ActionController::Base

    json_request :itemz, :only=>[:renamed]

    def update
      render :json=>params[:item]
    end
    
    def renamed
      render :json=>params[:itemz]
    end

  end

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller = ItemsController.new
    @item       = { 'foo'=>'1', 'bar'=>[2,3] }
  end

  def test_filter_renamed_parameter
    put :update, :_json=>@item
    assert_equal @item, ActiveSupport::JSON.decode(@response.body)
  end

  def test_filter_deletes_old_parameter
    put :update, :_json=>@item
    assert_nil @controller.params[:_json]
    assert_not_nil @controller.params[:item]
  end

  def test_plural_name_for_array
    put :update, :_json=>[@item]
    assert_nil @controller.params[:item]
    assert_equal [@item], @controller.params[:items]
  end

  def test_filter_can_override_param_name
    put :renamed, :_json=>@item
    assert_nil @controller.params[:item]
    assert_equal @item, @controller.params[:itemz]
  end

  def test_mime_parser
    body = @item.to_json
    env = { 'CONTENT_TYPE'   => 'application/json',
            'CONTENT_LENGTH' => body.size.to_s }
    cgi = ActionController::Integration::Session::StubCGI.new(env, body)
    put :update, ActionController::CgiRequest.new(cgi).request_parameters
    assert_equal @item, ActiveSupport::JSON.decode(@response.body)
  end

end
