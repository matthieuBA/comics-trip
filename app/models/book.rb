class Book < ApplicationRecord
  has_many :book_cards
  has_many :users, through: :book_cards

  # Active Storage
  has_one_attached :picture
      
  def self.isbn_exist(isbn)
      if Book.find_by(isbn: isbn).nil?
        puts "BOOK MUST BE CREATED"
        return false
      else
        puts "THE BOOK WITH THIS ISBN WAS FOUND"
        return true
      end
  end
end
