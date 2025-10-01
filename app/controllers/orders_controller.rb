class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.includes(order_items: :product).where(customer_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = Order.includes(order_items: :product).find(params[:id])
  end

  def new
    @order = Order.new
    
    if params[:product_id].present? && params[:quantity].present?
      product = Product.find_by(id: params[:product_id])
      quantity = params[:quantity].to_i

      if product && product.stock >= quantity && quantity > 0
        @order.order_items.build(product: product, quantity: quantity, unit_price: product.price, total_price: product.price * quantity)
      else
        flash[:alert] = "Invalid product or insufficient stock."
        redirect_to root_path and return
      end
    else
      cart = current_user.cart
      cart_items = cart.cart_items.includes(:product)
      
      if cart_items.empty?
        flash[:alert] = "Your cart is empty. Please add some products before checking out."
        redirect_to root_path
      end
      
      cart_items.each do |item|
        @order.order_items.build(product: item.product, quantity: item.quantity, unit_price: item.product.price, total_price: item.product.price * item.quantity)
      end
    end
    
    @order.total_amount = @order.order_items.sum(&:total_price)
  end

  # def create
  #   byebug
  #   @order = Order.new(order_params)
  #   @order.customer_id = current_user.id
  #   @order.status = "received"
  #   if @order.save
  #     # current_user.cart.cart_items.destroy
  #     # carts_controller = CartsController.new
  #     # carts_controller.empty_cart(current_user.cart)
  #     cart = current_user.cart
  #     cart.cart_items.destroy_all
  #     redirect_to orders_path, notice: "Hurray your order has been placed successfully!"
  #   else
  #     flash.now[:alert] = @order.errors.full_messages.to_sentence
  #     render :new
  #   end
  # end

  # def create
  #   # byebug
  #   @order = Order.new(order_params)
  #   @order.customer_id = current_user.id
  #   @order.status = :recieved

  #   cart = current_user.cart
  #   cart_items = cart.cart_items.includes(:product)

  #   @order.total_amount = cart_items.sum { |item| item.quantity * item.product.price }

  #   if @order.save
  #     cart_items.each do |item|
  #       order_item = @order.order_items.build( product_id: item.product_id, quantity: item.quantity, unit_price: item.product.price, total_price: item.quantity * item.product.price )

  #       unless order_item.save
  #         @order.destroy
  #         flash.now[:alert] = "Failed to create order items. Please try again."
  #         render :new
  #       end
  #     end

  #     cart.cart_items.destroy_all
  #     redirect_to orders_path, notice: "Hurray your order has been placed successfully!"
  #   else
  #     flash.now[:alert] = @order.errors.full_messages.to_sentence
  #     render :new
  #   end
  # end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_user.id
    @order.status = :recieved

    if @order.order_items.present?
      @order.total_amount = @order.order_items.sum(&:total_price)
    else
      flash.now[:alert] = "No items to place an order for."
      return render :new
    end

    if @order.save
      if params[:cart_based_order].to_s == "true"
        current_user.cart.empty!
      end
      redirect_to orders_path, notice: "Hurray! Your order has been placed successfully!"
    else
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.update(status: "cancelled")
    flash[:notice] = "Your order has been cancelled!"
    redirect_to orders_path
  end

  def return_order
    @order = Order.find(params[:id])
    @order.update(status: "returned")
    flash[:notice] = "Your order has been marked for return."
    redirect_to orders_path
  end

  private
    def order_params
      params.require(:order).permit(:payment_option, :delivery_address, :cart_based_order, order_items_attributes: [:product_id, :quantity, :unit_price, :total_price])
    end
end
