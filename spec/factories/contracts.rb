FactoryBot.define do
  factory :contract do
    sequence(:number) { |n| "Договор-#{n}" }
    date              { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    association :consumer, factory: :consumer

    after :create do |contract|
      create_list :counter, 3, contract: contract
    end
  end
end
