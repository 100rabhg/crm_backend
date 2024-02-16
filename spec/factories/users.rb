require 'faker'

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
