require 'spec_helper'

describe 'RestEngine Destroy' do
  describe 'DELETE a resource' do
    before(:all) do
      Sale.delete_all
      @sale = Factory.create(:sale)
      url = Rails.application.routes.url_helpers.rest_engine_destroy_path(
          :resources => 'sales',
          :id => @sale.id,
          :format => 'json'
      )
      delete(url)
    end

    it 'should respond successfully' do
      response.should be_successful
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the success message' do
      expected = {
          :success => true,
          :message => "Destroyed sales #{@sale.id}"
      }.to_json
      response.body.should == expected
    end

    it 'should delete the resource' do
      Sale.find_by_id(@sale.id).should be_nil
    end
  end
end