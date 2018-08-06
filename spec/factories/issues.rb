FactoryBot.define do
  factory :issue do
    urn "MyString"
    user
    scheme
    scheme_priority
    resident
    location
    description "MyText"
    trade "MyString"
    status "MyString"
  end
end
