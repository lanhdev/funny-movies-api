# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    user
    movie_id { [1, 2, 3].sample }
    like { [true, false].sample }
  end
end
