FactoryBot.define do
  factory :payment do
    company { Faker::Company.name }
    edrpou  { Faker::Company.edrpou }
    account { Faker::Bank.account_number(14) }
    bank    { Faker::Bank.name }
    mfo     { Faker::Bank.mfo }
  end
end
