class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.integer :quantity, default: 1, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
