require 'spec_helper'

describe 'GET non-available resources' do
  describe 'GET non-existing resources' do
    before(:all) do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'houses',
          :format => 'json'
      )
      get(url)
    end

    it 'should respond with 404 not found' do
      response.status.should == 404
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the not found message' do
      expected = {
          :success => false,
          :message => 'The resources "houses" do not exist.'
      }.to_json
      response.body.should == expected
    end
  end

  describe 'GET non-visible resources' do
    before do
      config_mock = mock(RestEngine::Config)
      RestEngine.stub!(:config).and_return(config_mock)
      config_mock.stub!(:model_visible?).with('Sale').and_return(false)
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
          :format => 'json'
      )
      get(url)
    end

    it 'should respond with 404 not found' do
      response.status.should == 404
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the not found message' do
      expected = {
          :success => false,
          :message => 'The resources "sales" do not exist.'
      }.to_json
      response.body.should == expected
    end
  end
end