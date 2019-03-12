Rails.application.routes.draw do

  scope module: :ship do
    resources :areas, only: [] do
      get :search, on: :collection
    end
  end

  scope :admin, module: 'ship/admin', as: 'admin' do
    resources :addresses
    resources :areas
  end

  scope :my, module: 'ship/my', as: 'my' do
    resources :addresses
  end


end
