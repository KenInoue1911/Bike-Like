FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 7) }
    post_bike { Faker::Lorem.characters(number: 5) }
    post_profile { Faker::Lorem.characters(number: 150) }
    user
  end
end