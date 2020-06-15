Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "static_pages#home"
devise_for :users

resources :users, only: [:show]

resources :index

resources :book_cards do
  resources :book_pictures, only: [:create]
end

resources :books do
  resources :pictures, only: [:create]
end

resources :landing_pages, only: [:index]
end
