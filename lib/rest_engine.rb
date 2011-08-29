require 'rest_engine/engine'
require 'rest_engine/config'

module RestEngine
  @@config = nil

  def self.config
    unless @@config
      config_file = File.join(Rails.root, 'config', 'rest_engine.yml')
      @@config = RestEngine::Config.new(config_file)
    end

    @@config
  end
end
