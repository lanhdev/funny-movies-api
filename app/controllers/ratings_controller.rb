# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :find_rating, only: %i[destroy]

  def create
    rating = current_user.ratings.build(rating_params)
    if rating.save
      render json: rating, status: :created
    else
      render json: { errors: rating.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @rating.destroy
    head :no_content
  end

  private

  def rating_params
    params.permit(:movie_id, :like)
  end

  def find_rating
    @rating = Rating.find(params[:id])
  end
end
