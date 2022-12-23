Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :admin, only: [:index] do
    collection do
      # match :login, to: "admin#login", via: [:post, :get]
      get :login
      post :login
    end
  end

  resources :users
end
