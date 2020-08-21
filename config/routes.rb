Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/dashboard', to: 'users#show'
  get '/discover', to: 'discover#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  resources :movies, only: [:show, :index]
  resources :view_party, only: [:new, :create]
end
