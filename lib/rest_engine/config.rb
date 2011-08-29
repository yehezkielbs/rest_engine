require 'rest_engine'

module RestEngine
  class Config
    def initialize config_file
      if File.exists?(config_file)
        @config = YAML.load_file(config_file)
      end
      @config ||= {}
    end

    def [] key
      @config[key]
    end 

    def model_visible? model
      visible = true
      if self['whitelisted_models']
        visible = self['whitelisted_models'].include?(model)
      elsif self['blacklisted_models']
        visible = !self['blacklisted_models'].include?(model)
      end
      visible
    end
  end
end
