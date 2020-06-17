require 'open-uri'

class BookCard < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :joins
  has_many :tags, through: :joins
  # View counter
  acts_as_punchable

  # Active Storage
  has_one_attached :book_picture

  def self.search(search)
    books = Book.where("title ILIKE ? OR author ILIKE ? OR genre ILIKE ? or isbn ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  
    book_cards = []

    books.each do |book|
      BookCard.where(book_id: book.id).each do |book_card|
        book_cards << book_card
      end
    end

    book_cards
  end
end
