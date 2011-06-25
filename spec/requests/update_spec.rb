require 'spec_helper'

describe 'RestEngine Update' do
  describe 'PUT a resource' do
    before(:all) do
      Sale.delete_all
      @sale = Factory.create(:sale)
      url = Rails.application.routes.url_helpers.rest_engine_update_path(
          :resources => 'sales',
          :id => @sale.id,
          :format => 'json'
      )
      now = DateTime.now
      @new_sale = {
          :name => "Updated Name #{now}",
          :address => "Updated Address #{now}",
          :sale_date => now.to_s
      }
      put(url, @new_sale)
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
      returned['data']['id'].should == @sale[:id]
      returned['data']['name'].should == @new_sale[:name]
      returned['data']['address'].should == @new_sale[:address]
      DateTime.parse(returned['data']['sale_date']).should == DateTime.parse(@new_sale[:sale_date])
    end

    it 'should update the data in database' do
      @sale.reload
      @sale.name.should == @new_sale[:name]
      @sale.address.should == @new_sale[:address]
      @sale.sale_date.should == DateTime.parse(@new_sale[:sale_date])
    end
  end
end