Rails.application.routes.draw do
  devise_for :users
  resources :people
  resources :groups do
    resources :group_users
    resources :mailouts do
      member do
        patch :send_email
      end
    end
  end
  root "groups#index"
end
