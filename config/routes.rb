Rails.application.routes.draw do

  namespace :ship, defaults: { business: 'ship' } do

    namespace :panel, defaults: { namespace: 'panel' } do
      resources :lines do
        resources :similars
      end
      resources :box_specifications do
        resources :boxes
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :stations
      resources :addresses
      resources :trade_items, except: [:destroy] do
        collection do
          post :package
        end
      end
      resources :packages, except: [:new, :create]
      resources :cars
      resources :lines do
        resources :locations
      end
      resources :box_specifications do
        resources :boxes
      end
      root 'home#index'
    end

    namespace :share, defaults: { namespace: 'share' } do
      resources :box_specifications do
        collection do
          get :buy
          get :rent
        end
      end
      resources :boxes
    end

    namespace :driver, defaults: { namespace: 'driver' } do
      resources :favorites
    end

    namespace :me, defaults: { namespace: 'me' } do
      resources :packages
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
