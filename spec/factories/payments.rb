FactoryBot.define do
  factory :payment do
    company { Faker::Company.name }
    edrpou  { Faker::Company.edrpou }
    account { Faker::Bank.iban('ua') }
    bank    { Faker::Bank.name }
    mfo     { Faker::Bank.mfo }
  end
end
