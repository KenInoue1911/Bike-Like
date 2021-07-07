FactoryBot.define do
  factory :message do
    message { Faker::Lorem.characters(number: 180) }
  end
end