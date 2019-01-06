Rails.application.routes.draw do
  root to: 'pages#show', page: 'home'
  get '*page', to: 'pages#show'
end
