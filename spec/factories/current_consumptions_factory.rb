FactoryBot.define do
  factory :current_consumption, class: CurrentConsumption do
    association :consumer
    power { 1 }
    tariff { 1.5 }
    money { 1.5 }
  end
end
