class CartItemsController < ApplicationController
  def new
    @cart_item = CartItem.new
  end

  # def create
  #   # byebug
  #   @product = Product.find(params[:product_id])
  #   # @cart = current_user.cart || current_user.create_cart
  #   @cart = current_user.cart

  #   @cart_item = @cart.cart_items.new(
  #     product: @product,
  #     quantity: params[:quantity] || 1
  #   )

  #   if @cart_item.save
  #     redirect_to product_path(@product), notice: "Product added to cart!"
  #   else
  #     redirect_to product_path(@product), status: :unprocessable_entity, alert: @cart_item.errors.full_messages.to_sentence
  #   end
  # end

  def create
    @product = Product.find(params[:product_id])
    @cart = current_user.cart || current_user.create_cart
    @cart_item = @cart.cart_items.find_by(product: @product)

    if @cart_item
      @cart_item.quantity += (params[:quantity]&.to_i || 1)
    else
      @cart_item = @cart.cart_items.new(product: @product, quantity: params[:quantity] || 1)
    end

    if @cart_item.save
      redirect_to product_path(@product), notice: "Product added to cart!"
    else
      redirect_to product_path(@product), status: :unprocessable_entity, alert: @cart_item.errors.full_messages.to_sentence
    end
  end

  def update
    # byebug
    @cart = current_user.cart
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: CartItem.find(params[:id]).quantity - 1)
    redirect_to cart_path(@cart), notice: "Item removed."
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Item removed."
  end

  private
    def cart_item_params
      params.permit(:product_id, :quantity)
    end
end
