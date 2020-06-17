Rails.application.routes.draw do
  get 'follow_relationships/follow_user'
  get 'follow_relationships/unfollow_user'

  #post ':user_email/follow_user', to: 'follow_relationships#follow_user', as: :follow_user
  #post ':user_email/unfollow_user', to: 'follow_relationships#unfollow_user', as: :unfollow_user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#home"

devise_for :users
resources :users, only: [:show] do
  resources :money_pots, only: [:show, :edit]
end

  resources :index

  resources :books

  resources :book_cards do
    resources :book_pictures, only: [:create]
  end

  resources :landing_pages, only: [:index]

  resources :google_books, only: [:index]

  resources :private_messages
end

