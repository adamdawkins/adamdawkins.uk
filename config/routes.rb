Rails.application.routes.draw do
  get ':year/:month/:day/:sequence', to: 'notes#show', as: :long_note
  get 'indiemark', to: 'indiemarks#index'
  resources :notes
  root to: 'notes#index'
  get '*page', to: 'pages#show'
end
