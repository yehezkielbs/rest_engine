Rails.application.routes.draw do
  scope 'api', :as => 'rest_engine' do
    controller 'rest_engine/main' do
      get    '/:resources',     :to => :list,    :as => 'list'
      post   '/:resources',     :to => :create,  :as => 'create'
      get    '/:resources/:id', :to => :show,    :as => 'show'
      put    '/:resources/:id', :to => :update,  :as => 'update'
      delete '/:resources/:id', :to => :destroy, :as => 'destroy'
    end
  end
end
