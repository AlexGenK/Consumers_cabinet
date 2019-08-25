FactoryBot.define do
  factory :payment do
    company { "MyString" }
    edrpou { Faker::Company.edrpou }
    account { 1234567890 }
    bank { "MyString" }
    mfo { Faker::Bank.mfo }
  end
end
