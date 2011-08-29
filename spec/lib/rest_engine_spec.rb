require 'spec_helper'

describe RestEngine do
  it 'should load config file, and only once' do
    config_file = File.expand_path('../../test_app/config/rest_engine.yml', __FILE__)
    config = RestEngine::Config.new(config_file)
    RestEngine::Config.should_receive(:new).with(config_file).once.and_return(config)
    RestEngine.config.should == config
    RestEngine.config.should == config
  end
end
