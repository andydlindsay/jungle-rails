class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @product = Product.find params[:id]
    @review = Review.create
  end

end
