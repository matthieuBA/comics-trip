class CreateBookCards < ActiveRecord::Migration[5.2]
  def change
    create_table :book_cards do |t|
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      t.decimal :price
      t.string :to_sell
      t.string :book_condition
      t.string :book_picture_seed
      t.text :review
      t.timestamps
    end
  end
end
