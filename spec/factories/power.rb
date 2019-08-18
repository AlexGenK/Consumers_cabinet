FactoryBot.define do
  factory :power, class: Power do
    measure_date  { Date.today }
    active            { 123 }
    before_active     { 120 }
    reactive          { 12 }
    before_reactive   { 10 }
    generation        { 3 }
    before_generation { 1 }
    association :counter, factory: :counter
  end
end