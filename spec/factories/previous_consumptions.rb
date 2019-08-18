FactoryBot.define do
  factory :previous_consumption, class: PreviousConsumption do
    association :consumer
    sequence(:date) { |n| (n % 12 + 1).month.ago }
    power { 25 }
    tariff { 2.7896 }
    money { 83.67 }
  end
end
