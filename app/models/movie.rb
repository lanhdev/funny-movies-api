# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :likes, -> { where(like: true) }, class_name: 'Rating'
  has_many :dislikes, -> { where(like: false) }, class_name: 'Rating'

  validates :user_id, :url, presence: true

  delegate :username, to: :user, allow_nil: true
end
