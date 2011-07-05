require 'spec_helper'

describe 'RestEngine Update' do
  describe 'PUT a namespaced resource' do
    before(:all) do
      Product::Toy.delete_all
      @toy = Factory.create(:toy)
      url = Rails.application.routes.url_helpers.rest_engine_update_path(
          :resources => 'product/toys',
          :id => @toy.id,
          :format => 'json'
      )
      now = DateTime.now
      @new_toy = {
          :name => "Updated Name #{now}",
          :description => "Updated Description #{now}"
      }
      put(url, @new_toy)
    end

    it 'should respond successfully' do
      response.should be_successful
    end

    it 'should return json' do
      response.headers['Content-Type'].should include 'application/json;'
    end

    it 'should return the requested data' do
      returned = JSON.parse(response.body)
      returned['success'].should be_true

      toy = returned['product/toys'][0]
      toy['id'].should == @toy.id
      toy['name'].should == @new_toy[:name]
      toy['description'].should == @new_toy[:description]
    end

    it 'should update the data in database' do
      @toy.reload
      @toy.name.should == @new_toy[:name]
      @toy.description.should == @new_toy[:description]
    end
  end
end
