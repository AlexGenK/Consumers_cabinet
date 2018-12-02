FactoryBot.define do
  factory :consumer, class: Consumer do
    sequence(:name)         { |n| "#{n} LTD" }
    edrpou                  { '01234567' }
    dog_eh_num              { '1/2' }
    dog_eh_date             { '12/05/2005' }
    sequence(:onec_id)      { |n| n }
    client_username         { 'client' }
    manager_username        { 'manager' }
    report_date             { 25 }
    sequence(:full_name)    { |n| "#{n} LTD & Co" }

    after :create do |consumer|
        create :current_consumption, consumer: consumer
        create_list :previous_consumption, 6, consumer: consumer
        create_list :contract, 3, consumer: consumer
    end
  end
end