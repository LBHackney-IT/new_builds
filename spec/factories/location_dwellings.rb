FactoryBot.define do
  factory :location_dwelling, class: 'Location::Dwelling' do
    name "Dwelling 1"
    association :parent, factory: :location_sub_block
    scheme
  end
end
