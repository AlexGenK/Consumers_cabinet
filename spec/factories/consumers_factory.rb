FactoryBot.define do
  factory :consumer, class: Consumer do
    name          { 'ЧП Пупкин В.С.' }
    onec_id       { 123 }
    edrpou        { '01234567' }
    dog_eh_num    { '1/2' }
    dog_eh_date   { '12/05/2005' }
    dog_hoe_num   { '10/12' }
    dog_hoe_date  { '24/01/2005' }
    report_date   { 25 }
    user_email    { 'user@mail.no' }
    manager_email { 'manager@mail.no' }
  end
end