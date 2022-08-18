Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    namespace :ship, defaults: { business: 'ship' } do
      resources :box_specifications do
        collection do
          get :rent
          get :invest
        end
      end
      resources :box_hosts, only: [:index] do
        member do
          get :boxes
          get :rentable
          get :rented
        end
      end
      resources :boxes, only: [] do
        collection do
          post :in_create
        end
        member do
          get :qrcode
          get 'in' => :in_edit
          post 'in' => :in_update
        end
      end
      resources :shipments, only: [] do
        member do
          get :qrcode
        end
      end
      resources :packages, only: [] do
        member do
          get :qrcode
        end
      end
      namespace :panel, defaults: { namespace: 'panel' } do
        root 'home#index'
        resources :lines do
          resources :similars
          resources :line_stations do
            member do
              patch :reorder
            end
          end
        end
        resources :stations
        resources :box_specifications do
          resources :boxes do
            collection do
              post :batch
              match :batch_pdf, via: [:get, :post]
            end
            member do
              get :pdf
            end
            resources :box_logs
            resources :rents do
              member do
                get :promote
                get :job
                put :compute
              end
            end
          end
        end
      end
      namespace :admin, defaults: { namespace: 'admin' } do
        resources :stations do
          member do
            get :lines
            get :shipments
          end
        end
        resources :addresses do
          collection do
            get :from
            get :packaged
            post :search
          end
          resources :items, only: [] do
            collection do
              get :packable
              get :packaged
              post :package
            end
          end
        end
        resources :items, except: [:destroy]
        resources :packages, except: [:new, :create] do
          resources :packageds
          collection do
            get :address
          end
          member do
            get :pdf
            get :print_data
            get :shipment_items
          end
        end
        resources :cars
        resources :drivers
        resources :lines do
          resources :line_stations
          resources :shipments do
            member do
              get :stations
              get 'loaded/:from_station_id' => :loaded
              post 'loaded' => :loaded_create
              get 'unloaded/:station_id' => :unloaded
              post 'unloaded' => :unloaded_create
              get 'transfer/:station_id' => :transfer
              post :leave
              post :arrive
            end
            resources :shipment_items
            resources :shipment_logs
            resources :payment_orders do
              collection do
                get 'station/:station_id' => :station
              end
              member do
                get 'payment' => :payment_new
                post 'payment' => :payment_create
              end
            end
          end
        end
        resources :box_hosts, only: [:index, :show] do
          resources :boxes do
            collection do
              post :batch
              match :batch_pdf, via: [:get, :post]
            end
            member do
              get :pdf
            end
            resources :box_logs
          end
        end
        root 'home#index'
      end
      namespace :in, defaults: { namespace: 'in' } do
        resources :box_specifications, only: [:index, :show] do
          collection do
            get :buy
            get :rent
          end
        end
        resources :boxes do
          collection do
            get :invest
            get :rent
          end
          resources :box_logs
          resources :rents do
            member do
              get :promote
              get :job
              put :compute
            end
          end
        end
        resources :orders do
          member do
            get :payment_types
            get 'payment_type' => :edit_payment_type
          end
          resources :items
        end
        resources :items
      end
      namespace :out, defaults: { namespace: 'out' } do
        resources :boxes do
          resources :rents
        end
      end
      namespace :our, defaults: { namespace: 'our' } do
        resources :orders do
          member do
            get :payment_types
            get 'payment_type' => :edit_payment_type
          end
          resources :items
        end
        resources :rents do
          member do
            get :promote
            get :job
            put :compute
          end
        end
        resources :boxes
      end
      namespace :driver, defaults: { namespace: 'driver' } do
        resources :favorites
      end
      namespace :me, defaults: { namespace: 'me' } do
        resources :packages do
          member do
            post :in
            post :out
            post :loaded
            post :unloaded
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
        resources :boxes do
          collection do
            get :owned
            get :invest
          end
          member do
            get :owned_show
          end
        end
        resources :addresses do
          collection do
            get :cart
            post :order
            post :order_new
            post :order_create
          end
          member do
            get :plans
          end
        end
        resources :packages do
          member do
            get :qrcode
            put :wait
            post :receive
          end
        end
      end
    end
  end
  resolve 'Ship::BoxSpecification' do |box_specification, options|
    [:ship, box_specification, options]
  end
end
