Rails.application.routes.draw do
  get 'training_forms/new'
  get 'training_forms/generate_pdf'
  get 'matches/edit'
  get 'seasons/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'training_forms/new', to: 'training_forms#new', as: 'new_training_form'
  post 'training_forms/generate_pdf', to: 'training_forms#generate_pdf', as: 'generate_pdf'
  resources :players do
    collection do
      get :download_pdf
    end
  end

  resources :teams
  resources :categories do
    member do
      post :generate_season
    end
  end
  resources :schools
  devise_for :users
  resources :matches, only: [:edit, :update]
  get 'show_pdf', to: 'players#show_pdf', defaults: { format: :pdf }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
