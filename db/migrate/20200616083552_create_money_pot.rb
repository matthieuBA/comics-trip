class CreateMoneyPot < ActiveRecord::Migration[5.2]
  def change
    create_table :money_pots do |t|
      t.belongs_to :user, index: true
      t.decimal :money

      t.timestamps
    end
  end
end
