Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "static_pages#home"
devise_for :users
resources :users, only: [:show]
resources :index
resources :book_cards
resources :books
resources :landing_pages, only: [:index]
resources :google_books, only: [:index]
resources :private_messages
end
