class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_seller, only: %i[edit update destroy]

  def index
    if current_user.seller?
      @products = current_user.products.includes(:seller)
    else
      @products = Product.all.includes(:seller)
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to product_path(@product), notice: "Product created successfully!"
    else
      flash.now[:alert] = @product.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Product updated successfully!"
    else
      flash.now[:alert] = @product.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully!", status: :see_other
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_seller
    unless @product.seller == current_user
      redirect_to products_path, alert: "You are not authorized to perform this action."
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
