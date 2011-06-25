require 'spec_helper'

describe 'RestEngine Show' do
  describe 'GET a resource' do
    before(:all) do
      Sale.delete_all
      @sale = Factory.create(:sale)
      url = Rails.application.routes.url_helpers.rest_engine_show_path(
          :resources => 'sales',
          :id => @sale.id,
          :format => 'json'
      )
      get(url)
    end

    it 'should respond successfully' do
      response.should be_successful
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the requested data' do
      expected = {
          :success => true,
          :data => @sale
      }.to_json
      response.body.should == expected
    end
  end
end