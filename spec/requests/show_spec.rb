require 'spec_helper'

describe 'GET a resource' do
  def do_action resources_name, id
    uri = Rails.application.routes.url_helpers.rest_engine_show_path(
        :resources => resources_name,
        :id => id,
        :format => 'json'
    )
    get(uri)
  end

  shared_examples_for 'successfuly request a resource' do |resource_name, factory_name|
    let(:resource) { Factory(factory_name) }
    before { do_action(resource_name.pluralize, resource.id) }

    it_behaves_like 'successful json response'

    it 'should return the requested resource' do
      expected = {
          'success' => true,
          resource_name.pluralize => [resource]
      }.to_json
      response.body.should == expected
    end
  end

  context 'when requesting an existing resource' do
    it_behaves_like 'successfuly request a resource', 'sale', :sale
  end

  context 'when requesting a namespaced resource' do
    it_behaves_like 'successfuly request a resource', 'product/toy', :toy
  end

  context 'when requesting a non-existing resource id' do
    it 'should return 404 not found' do
      expect { do_action(:sales, 123456) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when requesting a non-existing resource' do
    it 'should return 404 not found' do
      expect { do_action(:immortality_pills, 1) }.to raise_error(ActionController::RoutingError)
    end
  end
end
