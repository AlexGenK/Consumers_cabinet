FactoryBot.define do
  factory :counter, class: Counter do
    number  { 123456789 }
    ratio   { 10 }
    association :consumer, factory: :consumer
  end
end