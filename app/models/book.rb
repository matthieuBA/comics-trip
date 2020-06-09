class Book < ApplicationRecord
  has_many :book_cards
  has_many :users, through: :book_cards
end