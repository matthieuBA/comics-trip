class CreateBookCards < ActiveRecord::Migration[5.2]
  def change
    create_table :book_cards do |t|

      t.timestamps
    end
  end
end
