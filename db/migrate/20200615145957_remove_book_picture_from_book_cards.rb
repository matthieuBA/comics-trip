class RemoveBookPictureFromBookCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_cards, :book_picture, :string
  end
end
