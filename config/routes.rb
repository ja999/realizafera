Realizafera::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'

  get 'chief/graphic' => 'chief#graphic'
  get 'graphic' => 'graphics#show'
  get 'my_productions' => 'productions#my_productions'
  get 'user_annulments' => 'productions#user_annulments'

  resources :productions do
    member do
      get :cancel
      get :claim
    end
  end
  resources :free_spots
end
