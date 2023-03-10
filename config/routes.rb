Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "admin/users#index"

  namespace :admin do
    root "users#index"
    match :login, to: "sessions#create", via: [:get, :post], as: :login
    delete :logout, to: "sessions#destroy"

    resources :users
    resources :tests do
      collection do
        get :new_question_form, to: "questions#new"
        get :new_option_form, to: "questions#new_option"
      end
      resources :questions
      resources :options
    end

  end

  scope '/api/v1/' do
    post :login, to: "users#login"
    delete :logout, to: "users#logout"
    resources :tests do
      member do
        post :save_results
      end
    end
  end
end
