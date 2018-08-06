FactoryBot.define do
  factory :resident do
    name "MyString"
    phone "MyString"
    email "MyString"
    association :dwelling , factory: :location_dwelling
  end
end
