Rails.application.routes.draw do
  scope 'api', :as => 'rest_engine' do
    controller 'rest_engine/main' do
      get    '/*resources/:id(.:format)', :to => :show,    :as => 'show',    :constraints => { :id => /\d+/ }
      put    '/*resources/:id(.:format)', :to => :update,  :as => 'update',  :constraints => { :id => /\d+/ }
      delete '/*resources/:id(.:format)', :to => :destroy, :as => 'destroy', :constraints => { :id => /\d+/ }
      get    '/:resources(.:format)',     :to => :list,    :as => 'list',    :constraints => { :resources => /.+?/ }
      post   '/:resources(.:format)',     :to => :create,  :as => 'create',  :constraints => { :resources => /.+?/ }
    end
  end
end
