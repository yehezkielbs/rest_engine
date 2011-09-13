require 'spec_helper'
require 'ostruct'

describe 'POST a resource' do
  def do_action resources_name, resource
    uri = Rails.application.routes.url_helpers.rest_engine_create_path(
        :resources => resources_name,
        :format => 'json'
    )
    post(uri, resource)
  end

  shared_examples_for 'successfuly create a resource' do |resources_name, resource|
    before { do_action(resources_name, resource) }

    it_behaves_like 'successful json response'

    describe 'the returned data' do
      subject { OpenStruct.new(JSON.parse(response.body)[resources_name][0]) }

      resource.each_pair do |key, value|
        its(key) { should == value }
      end
    end

    describe 'the created data in DB' do
      subject { resources_name.classify.constantize.find(JSON.parse(response.body)[resources_name][0]['id']) }

      resource.each_pair do |key, value|
        its(key) { should == value }
      end
    end
  end

  context 'when creating a resource' do
    it_behaves_like 'successfuly create a resource', 'sales', {
        :name => "Name #{DateTime.now}",
        :address => "Address #{DateTime.now}"
    }
  end

  context 'when creating a nested resource' do
    it_behaves_like 'successfuly create a resource', 'product/toys', {
        :name => "Name #{DateTime.now}",
        :description => "Description #{DateTime.now}"
    }
  end

  context 'when trying to create a non-existing resource' do
    it 'should return 404 not found' do
      expect { do_action(:immortality_pills, {}) }.to raise_error(ActionController::RoutingError)
    end
  end
end