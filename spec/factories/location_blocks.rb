FactoryBot.define do
  factory :location_block, class: 'Location::Block' do
    name "Block 1"
    association :parent, factory: :location_estate
  end
end
