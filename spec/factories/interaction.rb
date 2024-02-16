require 'faker'

FactoryBot.define do
  factory :interaction do
    sequence(:subject) { |n| "subject#{n}" }
    sequence(:description) { |n| "description#{n}" }
    association :contact
  end
end
