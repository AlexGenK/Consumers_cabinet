FactoryBot.define do
  factory :consumer, class: Consumer do
    name        { 'ЧП Пупкин В.С.' }
    onec_id     { 123 }
    edrpou      { '01234567' }
    dog_eh_num  { '1/2' }
    dog_eh_date { '12/05/2005' }
  end
end