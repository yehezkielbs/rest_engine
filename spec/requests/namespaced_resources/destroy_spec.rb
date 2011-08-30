require 'spec_helper'

describe 'RestEngine Destroy' do
  describe 'DELETE a namespaced resource' do
    before(:all) do
      Product::Toy.delete_all
      @toy = Factory.create(:toy)
      url = Rails.application.routes.url_helpers.rest_engine_destroy_path(
          :resources => 'product/toys',
          :id => @toy.id,
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
          :message => "Destroyed product/toys #{@toy.id}"
      }.to_json
      response.body.should == expected
    end

    it 'should delete the resource' do
      Product::Toy.find_by_id(@toy.id).should be_nil
    end
  end
end