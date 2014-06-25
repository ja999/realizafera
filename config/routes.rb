Realizafera::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'

  get 'chief/graphic' => 'chief#graphic'
  get 'graphic' => 'graphics#show'

  resources :productions
  resources :free_spots
end
