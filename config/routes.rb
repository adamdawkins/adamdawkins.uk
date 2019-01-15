Rails.application.routes.draw do
  root to: 'notes#index'

  get 'login', to: 'sessions#new'
  get 'adam', to: 'adam/notes#new'

  resources :sessions, only: [:new, :create, :destroy]

  namespace :adam do
    resources :notes
  end

  resources :articles, only: :index

  get ':year/:month/:day/:slug', to: 'notes#show', as: :long_note
  get 'indiemark', to: 'indiemarks#index'

  resources :notes

  get '*page', to: 'pages#show'
end
