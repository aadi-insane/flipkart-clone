class ProductsController < ApplicationController
  before_action :authorize_seller!, only: [:edit, :update, :destroy]

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
    # @products = Product.all
    if user_signed_in? && current_user.seller?
      # @products = current_user.products_as_seller.includes(:seller)
      @products = Product.where(seller_id: current_user.id).order(created_at: :desc).page(params[:page])
    else
      @products = Product.all.order(created_at: :desc).page(params[:page])
    end
    # puts "----------------------------------------------"
    # puts "There are params - #{params}"
    # puts "There are params - #{current_user}"
    # puts "----------------------------------------------"
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
    if @product.update(product_params)
      redirect_to product_path(@product), notice: "Product has been updated successfully!"
    else
      flash.now[:alert] = "Something went wrong, cannot update product!"
      render :edit
    end
  end

  def destroy
  end

  # def search_product
  #   @query = params[:query]
    
  #   if @query.present?
  #     @results = Product.where("name ILIKE ?", "%#{@query}%")
  #   else
  #     flash[:alert] = "Please enter your query."
  #     redirect_to root_path
  #   end

  #   if @results
  #     @results = @results.paginate(page: params[:page], per_page: 10)
  #     flash.now[:notice] = "'#{@results.count}' results found."
  #   end
  #   # result.each do |r|
  #   #   puts r.name
  #   #   puts r.price
  #   #   puts r.description
  #   # end
  # end
    
  def search_product
    @query = params[:query].to_s.strip
    @category = params[:category].to_s.strip

    if @query.empty? && (@category.empty? || @category == "All Categories")
      flash[:alert] = "Please enter a search query or select a category."
      redirect_to root_path and return
      # @results = Product.none.paginate(page: params[:page], per_page: 10)
      # render :search_product and return
    end

    if user_signed_in? && current_user.seller?
      @results = Product.where(seller_id: current_user.id)
    else
      @results = Product.all
    end

    @results = @results.where("name ILIKE ?", "%#{@query}%") unless @query.empty?

    unless @category.empty? || @category == "All Categories"
      @results = @results.where(category: @category)
    end

    if @results.exists?
      @results = @results.paginate(page: params[:page], per_page: 12)
      flash.now[:notice] = "'#{@results.count}' results found."
    else
      @results = @results.paginate(page: params[:page], per_page: 12)
      flash.now[:alert] = "No results found."
    end

    render :search_product
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :seller_id, :brand, :category, :color, :size, :availability)
    end

    def authorize_seller!
      @product = Product.find(params[:id])
      unless current_user == @product.seller
        redirect_to root_path, alert: "You are not authorized to modify this product."
      end
    end
end
