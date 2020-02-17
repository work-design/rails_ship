Rails.application.routes.draw do

  scope module: :ship do
  end

  scope :admin, module: 'ship/admin', as: 'admin' do
    resources :addresses
    resources :rallies
  end

  scope :my, module: 'ship/my', as: 'my' do
    resources :addresses
    resources :rallies do
      member do
        get :join
      end
      resources :rally_users
    end
  end

end
