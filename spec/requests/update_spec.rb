require 'spec_helper'
require 'ostruct'

describe 'PUT a resource' do
  def do_action resources_name, id, new_attributes
    uri = Rails.application.routes.url_helpers.rest_engine_update_path(
        :resources => resources_name,
        :id => id,
        :format => 'json'
    )
    put(uri, new_attributes)
  end

  shared_examples_for 'successfuly update a resource' do |resources_name, factory_name, new_attributes|
    let(:resource) { Factory(factory_name) }
    before { do_action(resources_name, resource.id, new_attributes) }

    it_behaves_like 'successful json response'

    describe 'the returned data' do
      subject { OpenStruct.new(JSON.parse(response.body)[resources_name][0]) }

      new_attributes.each_pair do |key, value|
        its(key) { should == value }
      end
    end

    describe 'the created data in DB' do
      subject { resources_name.classify.constantize.find(resource.id) }

      new_attributes.each_pair do |key, value|
        its(key) { should == value }
      end
    end
  end

  context 'when updating a resource' do
    it_behaves_like 'successfuly update a resource', 'sales', :sale, {
        :name => "Updated name at #{DateTime.now}",
        :address => "Updated address at #{DateTime.now}"
    }
  end

  context 'when updating a nested resource' do
    it_behaves_like 'successfuly update a resource', 'product/toys', :toy, {
        :name => "Name #{DateTime.now}",
        :description => "Description #{DateTime.now}"
    }
  end

  context 'when trying to update a non-existing resource id' do
    it 'should return 404 not found' do
      expect { do_action(:sales, 123456, {}) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when trying to update a non-existing resource' do
    it 'should return 404 not found' do
      expect { do_action(:immortality_pills, 1, {}) }.to raise_error(ActionController::RoutingError)
    end
  end
end