require 'spec_helper'

describe 'RestEngine Create' do
  describe 'POST a namespaced resource' do
    before(:all) do
      Product::Toy.delete_all
      url = Rails.application.routes.url_helpers.rest_engine_create_path(
          :resources => 'product/toys',
          :format => 'json'
      )
      now = DateTime.now
      @toy = {
          :name => "Name #{now}",
          :description => "Description #{now}",
      }
      post(url, @toy)
    end

    it 'should respond successfully' do
      response.should be_successful
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the created data' do
      returned = JSON.parse(response.body)
      returned['success'].should be_true

      toy = returned['product/toys'][0]
      toy['name'].should == @toy[:name]
      toy['description'].should == @toy[:description]
    end

    it 'should create the data in database' do
      returned = JSON.parse(response.body)
      created_toy = Product::Toy.find(returned['product/toys'][0]['id'].to_i)
      created_toy.name.should == @toy[:name]
      created_toy.description.should == @toy[:description]
    end
  end
end
