Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'staticpages#top'

  get 'hiraganas/trial', to: 'hiraganas#trial', as: :trial_hiraganas

  resources :hiraganas, only: %i[index new create show destroy] do
    member do
      get 'study'
      get 'next'
      get 'next_word'
    end
    resources :favorites, only: %i[create destroy], param: :hiragana_favorite_id
  end

  resources :favorites, only: %i[index]

  resources :users, only: %i[new create]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # ログイン後のマイページへのルート
  get 'mypage', to: 'user_sessions#mypage', as: :mypage
end
