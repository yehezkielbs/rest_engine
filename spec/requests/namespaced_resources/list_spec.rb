require 'spec_helper'

describe 'RestEngine List' do
  describe 'GET namespaced resources as list' do
    before(:all) do
      Product::Toy.delete_all
      @toys = []
      5.times { @toys << Factory.create(:toy) }
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'product/toys',
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
          'product/toys' => @toys
      }.to_json
      response.body.should == expected
    end
  end

  describe 'GET namespaced resources as paginated list' do
    before(:all) do
      Product::Toy.delete_all
      @toys = []
      7.times { @toys << Factory.create(:toy) }
    end

    it 'should return first page data' do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'product/toys',
          :format => 'json',
          :limit => 5,
          :page => 1
      )
      get(url)

      expected = {
          :success => true,
          'product/toys' => @toys[0..4]
      }.to_json
      response.body.should == expected
    end

    it 'should return second page data' do
      url = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'product/toys',
          :format => 'json',
          :limit => 5,
          :page => 2
      )
      get(url)

      expected = {
          :success => true,
          'product/toys' => @toys[5..6]
      }.to_json
      response.body.should == expected
    end
  end
end

