FactoryGirl.define do
  factory :item_list do
    sequence(:title) { |n| "Item List title #{n}" }
    color 'red'
    association :user

    factory :public_list do
      public true
    end
  end
end
