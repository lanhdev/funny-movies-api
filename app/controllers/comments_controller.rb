# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    comments = Movie.find(params[:movie_id]).comments.order(created_at: :desc)
    render json: comments, status: :ok
  end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:movie_id, :content)
  end
end
