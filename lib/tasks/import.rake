require 'csv'

namespace :import do
  desc "Imports products from a CSV file"
  task products: :environment do
    # Correct file path using Rails.root
    path = Rails.root.join('products-1000.csv')

    puts "Importing products from #{path}..."

    CSV.foreach(path, headers: true) do |row|
      product = Product.find_or_initialize_by(name: row['name'])

      product.assign_attributes(
        description: row['description'],
        brand: row['brand'],
        category: row['category'],
        price: row['price'],
        stock: row['stock'],
        color: row['color'],
        size: row['size'],
        availability: row['availability'],
        seller_id: rand(30..79)
      )

      if product.save
        puts "Saved product: #{product.name}"
      else
        puts "Failed to save product: #{product.name}. Errors: #{product.errors.full_messages.to_sentence}"
      end
    end

    puts "Import finished."
  end
end
