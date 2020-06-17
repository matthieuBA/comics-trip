class Tag < ApplicationRecord
  has_many :joins
  has_many :book_cards, through: :joins
end
