class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users}
      t.integer :status
      t.string :delivery_address
      t.integer :payment_option
      t.decimal :total_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
