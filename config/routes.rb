Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      # Remove devise_scope and define routes directly
      post '/signup' => 'registrations#create'
      post '/login' => 'sessions#create'
      delete '/logout' => 'sessions#destroy'
    end
  end
end
