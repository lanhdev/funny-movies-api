FactoryBot.define do
  factory :jwt_blacklist do
    jti { Faker::Crypto.md5 }
    exp { 1.day.from_now }
  end
end
