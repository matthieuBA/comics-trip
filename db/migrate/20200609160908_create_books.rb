class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.string :isbn
      t.string :picture
      t.text :abstract
      t.text :extract

      t.timestamps
    end
  end
end
