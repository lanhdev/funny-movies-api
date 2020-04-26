FactoryBot.define do
  factory :movie do
    user
    url { Faker::Internet.url }
  end
end
