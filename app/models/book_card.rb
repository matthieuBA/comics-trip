require 'open-uri'

class BookCard < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # View counter
  acts_as_punchable

    # Active Storage
    has_one_attached :book_picture
  end
  