class AddNameAddressRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :Address, :string
    add_column :users, :role, :integer
  end
end
