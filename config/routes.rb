Rails.application.routes.draw do
  namespace :ship, defaults: { business: 'ship' } do
    resources :box_specifications do
      collection do
        get :rent
      end
    end
    namespace :panel, defaults: { namespace: 'panel' } do
      resources :lines do
        resources :similars
      end
      resources :box_specifications, only: [:index, :show] do
        resources :boxes
      end
    end
    namespace :admin, defaults: { namespace: 'admin' } do
      resources :stations do
        member do
          patch :actions
        end
      end
      resources :addresses do
        resources :trade_items, only: [] do
          collection do
            get :packable
            get :packaged
            post :package
          end
        end
      end
      resources :trade_items, except: [:destroy]
      resources :packages, except: [:new, :create]
      resources :cars
      resources :drivers
      resources :lines do
        resources :locations
      end
      resources :shipments
      resources :items
      resources :box_specifications do
        resources :boxes do
          collection do
            post :batch
          end
        end
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
      resources :boxes do
        collection do
          get :invest
        end
        resources :rents
      end
    end
    namespace :client, defaults: { namespace: 'client' } do
      resources :orders do
        member do
          get :payment_types
          get 'payment_type' => :edit_payment_type
        end
        resources :trade_items
      end
      resources :rents do
        member do
          get :promote
          get :job
          put :compute
        end
      end
    end
    namespace :driver, defaults: { namespace: 'driver' } do
      resources :favorites
    end
    namespace :me, defaults: { namespace: 'me' } do
      resources :packages do
        member do
          post :in
          post :out
          get :qrcode
        end
      end
      resources :boxes do
        member do
          post :in
          post :out
          get :qrcode
        end
      end
      resources :cars do
        collection do
          post :package_in
          post :package_out
        end
        member do
          get :qrcode
        end
      end
      resources :shipments do
        member do
          post :loaded
          post :unloaded
          get :qrcode
        end
      end
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
      resources :addresses do
        collection do
          post :order
        end
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

  resolve 'Ship::BoxSpecification' do |box_specification, options|
    [:ship, box_specification, options]
  end
end
