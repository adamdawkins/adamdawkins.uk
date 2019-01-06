Rails.application.routes.draw do
  root to: 'pages#index'
  get '*page', to: 'pages#show'
end
