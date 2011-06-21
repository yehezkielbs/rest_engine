require 'application_controller'

module RestEngine
  class MainController < RestEngine::ApplicationController
    def list
      render :nothing => true
    end
  end
end
