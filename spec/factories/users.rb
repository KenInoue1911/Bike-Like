FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    profile {Faker::Lorem.characters(number: 22) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end