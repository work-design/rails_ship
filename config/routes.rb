Rails.application.routes.draw do

  namespace :ship, defaults: { business: 'ship' } do

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :addresses do
        resources :trade_items do
          collection do
            post :package
          end
        end
      end
      resources :packages, except: [:new, :create]
      resources :lines do
        resources :locations
      end
    end

    namespace :my, defaults: { namespace: 'my' } do
      resources :lines do
        resources :locations
      end
      resources :principal_addresses, only: [:index, :show] do
        member do
          get :plans
        end
        resources :packages do
          member do
            put :wait
          end
        end
      end
    end

  end

end
