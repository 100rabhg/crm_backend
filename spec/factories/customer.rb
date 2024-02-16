require 'faker'

FactoryBot.define do
  factory :customer do
    sequence(:name) { |n| "Name#{n}" }
    email { Faker::Internet.email }
  end
end
