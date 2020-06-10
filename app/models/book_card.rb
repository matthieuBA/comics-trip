class BookCard < ApplicationRecord
  belongs_to :user
  belongs_to :book
  acts_as_punchable
  end