# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :id, :url, :username, :likes_count, :dislikes_count

  has_many :ratings

  def likes_count
    object.likes.size
  end

  def dislikes_count
    object.dislikes.size
  end
end
