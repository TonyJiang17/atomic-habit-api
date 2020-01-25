Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy] 
      post 'signup', to: 'sessions#signup', as: :signup
      get 'web/:id', to: 'web#habit_menu', as: :habit_menu
      resources :habits, only: [ :index,:show, :update, :create, :destroy ]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 