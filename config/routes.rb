MyNagios::Engine.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  root 'welcome#index'
  resources :checks do
    member do
      post :run_now
      post :toggle
    end
  end
end
