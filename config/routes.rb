Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "book_cards#index"
devise_for :users
resources :users, only: [:show]
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :index
resources :book_cards
end
