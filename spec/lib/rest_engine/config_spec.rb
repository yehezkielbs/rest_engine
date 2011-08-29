require 'spec_helper'
require 'yaml'

describe RestEngine::Config do
  def create_yaml_config_file config
    file = Tempfile.new(['rest_engine', '.yml'])
    file.write(YAML.dump(config))
    file.close
    file.path
  end

  it 'should read the config file' do
    config_data = { 'key' => 'value' }
    config_file = create_yaml_config_file(config_data)
    config = RestEngine::Config.new(config_file)

    config['key'].should == 'value'
  end

  it 'should whitelist models' do
    config_file = create_yaml_config_file({
      'whitelisted_models' => %w(model1 model2)
    })
    config = RestEngine::Config.new(config_file)

    config.model_visible?('model1').should be_true
    config.model_visible?('model2').should be_true
    config.model_visible?('model3').should be_false
  end

  it 'should blacklist models' do
    config_file = create_yaml_config_file({
      'blacklisted_models' => %w(model1 model2)
    })
    config = RestEngine::Config.new(config_file)

    config.model_visible?('model1').should be_false
    config.model_visible?('model2').should be_false
    config.model_visible?('model3').should be_true
  end
end
