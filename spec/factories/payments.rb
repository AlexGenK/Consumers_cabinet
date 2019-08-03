FactoryBot.define do
  factory :payment do
    company { "MyString" }
    edrpou { 1 }
    account { 1 }
    bank { "MyString" }
    mfo { 1 }
  end
end
