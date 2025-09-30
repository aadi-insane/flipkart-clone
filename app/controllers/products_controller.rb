class ProductsController < ApplicationController
  # def index
  #   # @products = Product.includes(:seller).where(seller_id: 2)
  #   # @products = Product.where(seller_id: 2)
  #   if current_user.seller?
  #     # @products = current_user.products_as_seller.includes(:seller)
  #     @products = Product.where(seller_id: params[:id])
  #   else
  #     @products = Product.all
      
  #   end
  # end
  def index
    
  end

  def new
    @product = Product.new
  end

  # def create
  #   # @product.seller_id = current_user.id
  #   @product = Product.new(product_params)
  #   if @product.save
  #     redirect_to product_path(@product), notice: "Product created successfully!"
  #   else
  #     render :edit, status: :unprocessable_content
  #     flash.now[:alert] = @product.errors.full_messages
  #   end
  # end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product), notice: "Product created successfully!"
    else
      flash.now[:alert] = @product.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to product_path(@product), notice: "Product has been updated successfully!"
  end

  def delete
  end

  def search_product
    @query = params[:query]
    
    if @query.present?
      @results = Product.where("name ILIKE ?", "%#{@query}%")
    else
      flash[:alert] = "Please enter your query."
      redirect_to root_path
    end

    if @results
      @results = @results.paginate(page: params[:page], per_page: 10)
      flash.now[:notice] = "'#{@results.count}' results found."
    end
    # result.each do |r|
    #   puts r.name
    #   puts r.price
    #   puts r.description
    # end
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :seller_id)
    end
end
