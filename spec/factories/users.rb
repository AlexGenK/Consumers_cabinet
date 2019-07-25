MANAGER_CLIENT_NAME = {'Ivan'  => ['Taya', 'Varya'],
                       'Roman' => ['Olya', 'Sveta', 'Nata']}

FactoryBot.define do
  factory :user_admin, class: User do
    username      { 'admin' }
    email         { Faker::Internet.unique.email }
    password      { '123456' }
    admin_role    { true }
    manager_role  { false }
    client_role   { false }
  end

  factory :user_manager, class: User do
    username      { 'manager' }
    email         { Faker::Internet.unique.email }
    password      { '123456' }
    admin_role    { false }
    manager_role  { true }
    client_role   { false }
  end

  factory :user_client, class: User do
    username      { 'client' }
    email         { Faker::Internet.unique.email }
    password      { '123456' }
    admin_role    { false }
    manager_role  { false }
    client_role   { true }
  end
end
