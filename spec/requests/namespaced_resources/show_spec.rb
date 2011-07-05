require 'spec_helper'

describe 'RestEngine Show' do
  describe 'GET a namespaced resource' do
    before(:all) do
      Product::Toy.delete_all
      @toys = Factory.create(:toy)
      url = Rails.application.routes.url_helpers.rest_engine_show_path(
          :resources => 'product/toys',
          :id => @toys.id,
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
          'product/toys' => [@toys]
      }.to_json
      response.body.should == expected
    end
  end
end
