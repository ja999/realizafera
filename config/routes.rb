Realizafera::Application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'chief/graphic' => 'chief#graphic'

  resources :productions
end
