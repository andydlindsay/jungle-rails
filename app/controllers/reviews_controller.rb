class ReviewsController < ApplicationController

    before_filter :authorize

    def create
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        @product = Product.find params[:product_id]
        review = Review.new({
            description: review_params[:description],
            rating: review_params[:rating],
            user_id: @current_user.id,
            product_id: params[:product_id]
        })
        review.save
        redirect_to @product
    end

    def destroy
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        @review.destroy
        redirect_to @product, notice: 'Review deleted'
    end

    private

    def review_params
        params.require(:review).permit(
            :description,
            :rating
        )
    end

end
