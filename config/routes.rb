Realizafera::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: "registrations" }
  root 'home#index'

  get 'chief/graphic' => 'chief#graphic'
  get 'graphic' => 'graphics#show'
  get 'my_productions' => 'productions#my_productions'
  get 'user_annulments' => 'productions#user_annulments'
  get 'exchange' => 'productions#exchange'
  get 'available_productions' => 'productions#available_productions'

  resources :productions do
    member do
      get :cancel
      get :claim
    end
  end
  resources :free_spots
end
