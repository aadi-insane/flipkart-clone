class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    @ransackable_attributes ||= column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
  end

  def self.ransackable_associations(auth_object = nil)
    # byebug
    ["cart", "product"]
  end

  # before_initialize :set_products_cart_cart_items


  # private
  #   def set_products_cart_cart_items
  #     @product = Product.find(params[:product_id])
  #     @cart = current_user.cart
  #     @cart_item = @cart.cart_items.find_by(product: @product)
  #   end
end
