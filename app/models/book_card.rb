require 'open-uri'

class BookCard < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # View counter
  acts_as_punchable

  # Active Storage
  has_one_attached :book_picture

  def self.search(search)
    book_id = []
    book_id = Book.where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ? or isbn ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    puts "#"*50
    puts book_id
    puts "#"*50

  end
end
