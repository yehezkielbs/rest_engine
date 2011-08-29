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

      items = @model.all(options)

      respond(:success => true, @resources => items)
    end

    def show
      item = @model.find(params[:id])
      respond(:success => true, @resources => [item])
    end

    def destroy
      item = @model.find(params[:id])
      if item.destroy
        respond(:success => true, :message => "Destroyed #{@model_name} #{item.id}")
      else
        respond(:success => false, :message => "Failed to destroy #{@model_name} #{item.id}")
      end
    end

    def create
      item = @model.new(request.POST)
      if item.save
        respond(:success => true, :message => "Created new #{@model_name} #{item.id}", @resources => [item])
      else
        respond(:success => false, :message => "Failed to create #{@model_name}")
      end
    end

    def update
      item = @model.find(params[:id])
      if item.update_attributes(request.POST)
        respond(:success => true, :message => "Updated #{@model_name} #{item.id}", @resources => [item])
      else
        respond(:success => false, :message => "Failed to update #{@model_name}")
      end
    end

    private

    def respond data, status = 200
      ActiveRecord::Base.include_root_in_json = false
      respond_to do |format|
        format.any(:xml, :json) { render(:status => status, request.format.to_sym => data) }
      end
    end

    def get_model
      @resources = params[:resources]
      @model_name = @resources.classify
      if RestEngine.config.model_visible?(@model_name)
        begin
          @model = @model_name.constantize
        rescue NameError
          respond_with_not_found
        end
      else
        respond_with_not_found
      end
    end

    def respond_with_not_found
      respond({:success => false, :message => %(The resources "#{@resources}" do not exist.)}, 404)
    end
  end
end
