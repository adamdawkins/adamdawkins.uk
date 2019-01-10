Rails.application.routes.draw do
  get ':year/:month/:day/:sequence', to: 'notes#show', as: :long_note
  resources :notes
  root to: 'notes#index'
  get '*page', to: 'pages#show'
end
