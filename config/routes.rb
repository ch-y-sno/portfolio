Rails.application.routes.draw do
  root "home#top"

  get "home" => "home#index"

  resources :users, only: %i[new create update destroy show]

  get "login" => "user_sessions#new", :as => :login
  post "login" => "user_sessions#create"
  delete "logout" => "user_sessions#destroy", :as => :logout

  resource :profile, only: %i[show update edit]

  resources :articles, only: %i[index new create edit update show destroy upload_image] do
    resources :comments, only: %i[create edit destroy update], shallow: true
  end

  resources :teams, only: %i[new index create show edit update] do
    resources :members, only: %i[index]
    resources :member_requests, only: %i[new create delete show update]
    resources :topics, only: %i[new create]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
