class OrdersController < ApplicationController
  def index
    
    # @orders = Order.where(customer_id: current_user.id)
    # @orders = Order.includes(:customer, order_items: :product).where(customer_id: current_user.id)
    @orders = Order.includes(order_items: :product).where(customer_id: current_user.id).order(created_at: :desc).page(params[:page])
    # byebug
  end

  def show
    # @order = Order.find(params[:id])
    @order = Order.includes(order_items: :product).find(params[:id])
  end

  def new
    @order = Order.new
    @cart = current_user.cart
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

  def create
    # byebug
    @order = Order.new(order_params)
    @order.customer_id = current_user.id
    @order.status = :recieved

    cart = current_user.cart
    cart_items = cart.cart_items.includes(:product)

    @order.total_amount = cart_items.sum { |item| item.quantity * item.product.price }

    if @order.save
      cart_items.each do |item|
        order_item = @order.order_items.build( product_id: item.product_id, quantity: item.quantity, unit_price: item.product.price, total_price: item.quantity * item.product.price )

        unless order_item.save
          @order.destroy
          flash.now[:alert] = "Failed to create order items. Please try again."
          render :new
        end
      end

      cart.cart_items.destroy_all
      redirect_to orders_path, notice: "Hurray your order has been placed successfully!"
    else
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  def cancel_order
    # byebug
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
      params.require(:order).permit(:payment_option, :delivery_address, :total_amount)
    end
end