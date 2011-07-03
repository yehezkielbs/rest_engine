require 'spec_helper'

describe 'RestEngine Create' do
  describe 'POST a resource' do
    before(:all) do
      Sale.delete_all
      url = Rails.application.routes.url_helpers.rest_engine_create_path(
          :resources => 'sales',
          :format => 'json'
      )
      now = DateTime.now
      @sale = {
          :name => "Name #{now}",
          :address => "Address #{now}",
          :sale_date => now.to_s
      }
      post(url, @sale)
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

      sale = returned['sales'][0]
      sale['name'].should == @sale[:name]
      sale['address'].should == @sale[:address]
      DateTime.parse(sale['sale_date']).should == DateTime.parse(@sale[:sale_date])
    end

    it 'should create the data in database' do
      returned = JSON.parse(response.body)
      created_sale = Sale.find(returned['sales'][0]['id'].to_i)
      created_sale.name.should == @sale[:name]
      created_sale.address.should == @sale[:address]
      created_sale.sale_date.should == DateTime.parse(@sale[:sale_date])
    end
  end
end
