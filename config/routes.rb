Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :items do
    resources :orders, only:[:index, :new, :create] do
      resources :address, only: :create
    end
  end
end
