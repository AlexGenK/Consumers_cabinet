FactoryBot.define do
  factory :contract do
    sequence(:number) { |n| "Договор #{n}" }
    date              { "2018-11-25" }
    association :consumer, factory: :consumer

    after :create do |contract|
      create_list :counter, 3, contract: contract
    end
  end
end
