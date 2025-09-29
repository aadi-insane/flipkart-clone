class HomeController < ApplicationController
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
end
