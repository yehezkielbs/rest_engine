require 'spec_helper'

describe 'RestEngine Basic List' do
  describe 'GET /api/sales.json as list' do
    before(:each) do
      21.times { Factory.create :sale }
      get( Rails.application.routes.url_helpers.rest_engine_list_path(:model_name => 'sales'))
    end

    it 'should respond successfully' do
      response.should be_successful
    end
  end
end
