Rails.application.routes.draw do
  get 'landing_pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "static_pages#home"
devise_for :users
resources :users, only: [:show]
resources :index
resources :book_cards
resources :books

end
