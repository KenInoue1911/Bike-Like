FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 100) }
  end
end