Rails.application.routes.draw do
  scope 'api', :as => 'rest_engine' do
    controller 'rest_engine/main' do
      get '/:model_name', :to => :list, :as => 'list'
    end
  end
end
