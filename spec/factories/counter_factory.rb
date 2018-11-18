FactoryBot.define do
  factory :counter, class: Counter do
    sequence(:number)  { |n| n }
    ratio   { 10 }
    association :consumer, factory: :consumer
  end
end