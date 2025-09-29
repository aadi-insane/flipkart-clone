class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    # puts "There are params - #{params}"
  end

  def empty_cart
    @cart = current_user.cart
    @cart.cart_items.destroy_all
    flash[:notice] = "Your cart has been emptied."
    redirect_to cart_path
  end
end
