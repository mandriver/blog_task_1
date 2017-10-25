class RatingController < ApplicationController
  def set
    @rating = Rating.new(set_params)
    if @rating.save
      render json: @rating, status: 200
    else
      render json: @rating.errors, status: 400
    end
  end

  private

  def set_params
    params.require(:rating).permit(:value, :post_id)
  end
end
