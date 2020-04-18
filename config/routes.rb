Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'tests#index'
  resources :tests
  resources :cards, only: %i[new create show  destroy] 
  resources :items, only: %i[new create]

  devise_scope :user do
    post 'users/sign_up/complete' => 'users/registrations#complete'
  end
end
