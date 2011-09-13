require 'spec_helper'

describe 'DELETE a resource' do
  def do_action resources_name, id
    uri = Rails.application.routes.url_helpers.rest_engine_destroy_path(
        :resources => resources_name,
        :id => id,
        :format => 'json'
    )
    delete(uri)
  end

  shared_examples_for 'successfuly delete a resource' do |resources_name, factory_name|
    let(:resource) { Factory(factory_name) }
    before { do_action(resources_name, resource.id) }

    it_behaves_like 'successful json response'

    it 'should delete the resource from DB' do
      resources_name.classify.constantize.find_by_id(resource.id).should be_nil
    end
  end

  context 'when destroying a resource' do
    it_behaves_like 'successfuly delete a resource', 'sales', :sale
  end

  context 'when destroying a nested resource' do
    it_behaves_like 'successfuly delete a resource', 'product/toys', :toy
  end

  context 'when trying to destroy a non-existing resource id' do
    it 'should return 404 not found' do
      expect { do_action(:sales, 123456) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when trying to destroy a non-existing resource' do
    it 'should return 404 not found' do
      expect { do_action(:immortality_pills, 1) }.to raise_error(ActionController::RoutingError)
    end
  end
end