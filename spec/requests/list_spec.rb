require 'spec_helper'

describe 'GET resources' do
  def do_action resources_name, page = nil, limit = nil, options = {}
    uri = Rails.application.routes.url_helpers.rest_engine_list_path(
        {
            :resources => resources_name,
            :format => 'json',
            :page => page,
            :limit => limit
        }.merge(options)
    )
    get(uri)
  end

  shared_examples_for 'successfuly request resources' do |resources_name, factory_name|
    before(:all) do
      Factory.factory_by_name(factory_name).build_class.delete_all
      @resources = (1..5).map { Factory.create(factory_name) }
    end
    let(:resources) { @resources }
    before { do_action(resources_name) }

    it_behaves_like 'successful json response'

    it 'should return the requested resources' do
      expected = {
          'success' => true,
          resources_name => resources
      }.to_json
      response.body.should == expected
    end
  end

  context 'when requesting existing resources' do
    it_behaves_like 'successfuly request resources', 'sales', :sale
  end

  context 'when requesting namespaced resources' do
    it_behaves_like 'successfuly request resources', 'product/toys', :toy
  end

  context 'when requesting resources as paginated list' do
    before(:all) { Sale.delete_all; @sales = (1..7).map { Factory.create(:sale) } }
    let(:sales) { @sales }

    it 'should return first page data' do
      do_action(:sales, 1, 5)
      expected = {
          'success' => true,
          'sales' => sales[0..4]
      }.to_json
      response.body.should == expected
    end

    it 'should return second page data' do
      do_action(:sales, 2, 5)
      expected = {
          'success' => true,
          'sales' => sales[5..6]
      }.to_json
      response.body.should == expected
    end
  end

  context 'when includes associations' do
    before do
      Sale.delete_all
      Factory.create(:sale_with_5_items)
    end

    it 'should return the requested data including the associated data' do
      do_action(:sales, nil, nil, {:include => 'associations'})
      returned = JSON.parse(response.body)
      returned['sales'][0]['sale_items'].length.should == 5
    end
  end

  context 'when requesting non-existing resources' do
    it 'should return 404 not found' do
      expect { do_action(:immortality_pills) }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'when requesting non-visible resources' do
    it 'should return 404 not found' do
      config_mock = mock(RestEngine::Config)
      RestEngine.stub!(:config).and_return(config_mock)
      config_mock.stub!(:model_visible?).with('Sale').and_return(false)
      uri = Rails.application.routes.url_helpers.rest_engine_list_path(
          :resources => 'sales',
          :format => 'json'
      )

      lambda { get(uri) }.should raise_error(ActionController::RoutingError)
    end
  end
end
