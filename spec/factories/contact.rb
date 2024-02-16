require 'faker'

FactoryBot.define do
  factory :contact do
    sequence(:address) { |n| "Address#{n}" }
    phone_number { Faker::PhoneNumber.phone_number }
    association :customer
  end
end
