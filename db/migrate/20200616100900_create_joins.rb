class CreateJoins < ActiveRecord::Migration[5.2]
  def change
    create_table :joins do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :book_card, index: true

      t.timestamps
    end
  end
end
