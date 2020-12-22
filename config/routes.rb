Rails.application.routes.draw do

  scope module: :ship, defaults: { namespace: 'application', business: 'ship' } do
  end

  scope :admin, module: 'ship/admin', as: 'admin' do
    resources :addresses do
      resources :trade_items do
        collection do
          post :package
        end
      end
    end
    resources :packages, except: [:new, :create]
  end

  scope :my, module: 'ship/my', as: :my, defaults: { namespace: 'my', business: 'ship' } do
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
