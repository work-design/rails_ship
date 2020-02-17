Rails.application.routes.draw do

  scope module: :ship do
  end

  scope :admin, module: 'ship/admin', as: 'admin' do
    resources :addresses
  end

  scope :my, module: 'ship/my', as: 'my' do
    resources :addresses
    resources :rallies do
      member do
        get :join
      end
    end
  end


end
