Rails.application.routes.draw do

  scope module: :ship do
  end

  scope :admin, module: 'ship/admin', as: 'admin' do
    resources :addresses do
      resources :trade_items
    end
  end

  scope :my, module: 'ship/my', as: 'my' do
  end

end
