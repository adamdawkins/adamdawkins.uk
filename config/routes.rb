Rails.application.routes.draw do
  constraints host: ENV['SHORT_URL'] do
    get '/:id' => 'short_domains#post'
    match "/(*path)", to: redirect {|p, req| "//#{ENV['FULL_URL']}#{req.fullpath}"}, via: [:get, :head]
  end

  constraints host: ENV['FULL_URL'] do
    root to: 'posts#index'

    get 'login', to: 'sessions#new'
    get 'adam', to: 'adam/posts#index'

    namespace :adam do
      resources :syndicates, only: :destroy
      resources :posts do
        resources :syndicates, only: :create
      end
      resources :notes
      resources :articles
      put "notes/:id/publish", to: "notes#publish", as: "publish_note"
      put "articles/:id/publish", to: "articles#publish", as: "publish_article"
    end

    resources :sessions, only: [:new, :create, :destroy]

    get ':year/:month/:day/:slug', to: 'posts#show', as: :long_post
    get 'indiemark', to: 'indiemarks#index'

    resources :articles, only: :index
    resources :notes, only: :index

    get '*page', to: 'pages#show'
  end
end
