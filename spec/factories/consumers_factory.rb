FactoryBot.define do
  factory :consumer, class: Consumer do
    name                { 'Пупкин ЧП' }
    edrpou              { '01234567' }
    dog_eh_num          { '1/2' }
    dog_eh_date         { '12/05/2005' }
    dog_hoe_num         { '10/12' }
    dog_hoe_date        { '24/01/2005' }
    onec_id             { 123 }
    client_username     { 'user@mail.no' }
    manager_username    { 'manager@mail.no' }
    report_date         { 25 }
    full_name           { 'ЧП Пупкин А.Б.' }

    after :create do |consumer|
        create :current_consumption, consumer: consumer
        create_list :previous_consumption, 6, consumer: consumer
    end
  end
end