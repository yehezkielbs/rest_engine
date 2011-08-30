require 'application_controller'

module RestEngine
  class MainController < RestEngine::ApplicationController
    before_filter :get_model

    def list
      options = {}
      if params[:page]
        page = params[:page].to_i
        page = 1 if page <= 0

        options[:limit] = params[:limit].to_i
        options[:offset] = (page - 1) * options[:limit]
      end

      @items = @model.all(options)
    end

    def show
      @item = @model.find(params[:id])
    end

    def destroy
      @item = @model.find(params[:id])
      @success = !!@item.destroy
    end

    def create
      @item = @model.new(request.POST)
      @success = !!@item.save
    end

    def update
      @item = @model.find(params[:id])
      @success = !!@item.update_attributes(request.POST)
    end

    private

    def get_model
      @resources = params[:resources]
      @model_name = @resources.classify
      if RestEngine.config.model_visible?(@model_name)
        begin
          @model = @model_name.constantize
        rescue NameError
          not_found
        end
      else
        not_found
      end
    end

    def not_found
      raise ActionController::RoutingError.new('The resources you were looking for do not exist')
    end
  end
end
