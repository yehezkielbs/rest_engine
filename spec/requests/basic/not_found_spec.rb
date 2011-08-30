require 'spec_helper'

describe 'GET non-available resources' do
  context 'GET non-existing resources' do
    it 'should respond with 404 not found' do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'houses',
          :format => 'json'
      )

      lambda { get(url) }.should raise_error(ActionController::RoutingError)
    end
  end

  context 'GET non-visible resources' do
    it 'should respond with 404 not found' do
      config_mock = mock(RestEngine::Config)
      RestEngine.stub!(:config).and_return(config_mock)
      config_mock.stub!(:model_visible?).with('Sale').and_return(false)
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
          :format => 'json'
      )

      lambda { get(url) }.should raise_error(ActionController::RoutingError)
    end
  end
end