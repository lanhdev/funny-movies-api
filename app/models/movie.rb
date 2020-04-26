class Movie < ApplicationRecord
  belongs_to :user

  validates :user_id, :url, presence: true

  delegate :username, to: :user, allow_nil: true
end
