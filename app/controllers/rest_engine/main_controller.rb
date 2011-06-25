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

      respond(:success => true, :data => items)
    end

    def show
      item = @model.find(params[:id])
      respond(:success => true, :data => item)
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
        respond(:success => true, :message => "Created new #{@model_name} #{item.id}", :data => item)
      else
        respond(:success => false, :message => "Failed to create #{@model_name}")
      end
    end

    def update
      item = @model.find(params[:id])
      if item.update_attributes(request.POST)
        respond(:success => true, :message => "Updated #{@model_name} #{item.id}", :data => item)
      else
        respond(:success => false, :message => "Failed to update #{@model_name}")
      end
    end

    private

    def respond data
      ActiveRecord::Base.include_root_in_json = false
      respond_to do |format|
        format.any(:xml, :json) { render(request.format.to_sym => data) }
      end
    end

    def get_model
      @model_name = to_model_name(params[:resources])
      @model = @model_name.constantize
    end

    def to_model_name(resources_name)
      parts = resources_name.split('~')
      parts.map { |x| x == parts.last ? x.classify : x.camelize }.join('::')
    end
  end
end
