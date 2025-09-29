class AddForeignKeyToProducts < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :products, :users, column: :seller_id
    add_index :products, :seller_id
  end
end
