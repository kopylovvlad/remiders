FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "Item title #{n}" }
    description 'Description for First Item'
    association :item_list
  end
end
