Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'episodes/:id/new', to: 'episodes#new', as: 'new_episode'
  post 'episodes/:id/create', to: 'episodes#cre', as: 'episode'
  delete "episodes/:id/create",to: "episodes#destroy"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  get "signup", to: "users#new"
  get "influencer_ranking", to: "users#rank"
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    member do
      get :influences
      get :influencers
    end
  end
  resources :challenges, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :episodes, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
end