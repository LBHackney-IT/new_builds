FactoryBot.define do
  factory :issue do
    urn "MyString"
    user nil
    scheme nil
    scheme_priority nil
    resident nil
    location nil
    description "MyText"
    trade "MyString"
    status "MyString"
  end
end
