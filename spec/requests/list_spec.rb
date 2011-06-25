require 'spec_helper'

describe 'RestEngine List' do
  describe 'GET resources as list' do
    before(:all) do
      Sale.delete_all
      @sales = []
      5.times { @sales << Factory.create(:sale) }
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
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
          :data => @sales
      }.to_json
      response.body.should == expected
    end
  end

  describe 'GET resources as paginated list' do
    before(:all) do
      Sale.delete_all
      @sales = []
      7.times { @sales << Factory.create(:sale) }
    end

    it 'should return first page data' do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
          :format => 'json',
          :limit => 5,
          :page => 1
      )
      get(url)

      expected = {
          :success => true,
          :data => @sales[0..4]
      }.to_json
      response.body.should == expected
    end

    it 'should return second page data' do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
          :format => 'json',
          :limit => 5,
          :page => 2
      )
      get(url)

      expected = {
          :success => true,
          :data => @sales[5..6]
      }.to_json
      response.body.should == expected
    end
  end
end
