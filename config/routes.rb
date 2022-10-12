Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :categories, only: [:index, :new, :create] do
    resources :operations, only: [:index, :new, :create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "categories#index"
end
