Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :repositories
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :show]
      resources :sessions, only: [:create, :show]
      post 'forgot-password', to: 'passwords#forgot_password'
      post 'update-password', to: 'passwords#update_password'
    end
  end
end
