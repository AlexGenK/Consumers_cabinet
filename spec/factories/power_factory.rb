FactoryBot.define do
  factory :power, class: Power do
    measure_date  { Date.today }
    active        { 123 }
    reactive      { 12 }
    generation    { 3 }
    association :counter, factory: :counter
  end
end