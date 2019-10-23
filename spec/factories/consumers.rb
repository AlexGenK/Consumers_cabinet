FactoryBot.define do
  factory :consumer, class: Consumer do
    name                    { Faker::Company.unique.name }
    edrpou                  { Faker::Company.edrpou }
    dog_eh_num              { '1/2' }
    dog_eh_date             { '12/05/2005' }
    sequence(:onec_id)      { |n| n }
    client_username         { build(:user_client).username }
    manager_username        { build(:user_manager).username }
    report_date             { 25 }
    sequence(:full_name)    { |n| "#{n} #{Faker::Company.name}" }

    after :create do |consumer|
        create :current_consumption, consumer: consumer
        create_list :previous_consumption, 6, consumer: consumer
        create_list :contract, 3, consumer: consumer
    end
  end
end