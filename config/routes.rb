MyNagios::Engine.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  root 'welcome#index'
  match 'autorefresh',    to: 'welcome#autorefresh',    via: [:post]
  match 'group_action',   to: 'checks#group_action',    via: [:post]

  resources :checks do
    member do
      post :run_now
      post :toggle
    end
  end
end
