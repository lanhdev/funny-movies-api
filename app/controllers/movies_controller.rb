class MoviesController < ApplicationController
  before_action :authenticate_user!, only: %i(create)

  def index
    render json: Movie.all.order(created_at: :desc), status: :ok
  end

  def create
    movie = current_user.movies.build(movie_params)
    if movie.save
      render json: movie, status: :created
    else
      render json: { errors: movie.errors }, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.permit(:url)
  end
end
