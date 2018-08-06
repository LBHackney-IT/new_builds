FactoryBot.define do
  factory :location_sub_block, class: 'Location::SubBlock' do
    name "Sub Block 1"
    association :parent, factory: :location_block
  end
end
