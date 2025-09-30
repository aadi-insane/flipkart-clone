class AddBrandCategoryColorSizeAndAvailabilityToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :brand, :string
    add_column :products, :category, :string
    add_column :products, :color, :string
    add_column :products, :size, :string
    add_column :products, :availability, :string
  end
end
