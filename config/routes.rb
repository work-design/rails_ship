Rails.application.routes.draw do

  namespace :ship, defaults: { business: 'ship' } do

    namespace :panel, defaults: { namespace: 'panel' } do
      resources :lines do
        resources :similars
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :stations
      resources :addresses do
        resources :trade_items do
          collection do
            post :package
          end
        end
      end
      resources :packages, except: [:new, :create]
      resources :cars
      resources :lines do
        resources :locations
      end
      root 'home#index'
    end

    namespace :driver, defaults: { namespace: 'driver' } do
      resources :favorites
    end

    namespace :my, defaults: { namespace: 'my' } do
      resource :driver
      resources :favorites
      resources :cars
      resources :lines do
        collection do
          get :requirement
          post :add
          post :select
        end
        resources :locations
      end
      resources :stations
      resources :addresses
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
