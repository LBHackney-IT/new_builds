FactoryBot.define do
  factory :resident do
    name "Resident Name"
    phone "07777777"
    email "resident@test.com"
    association :dwelling , factory: :location_dwelling
  end
end
