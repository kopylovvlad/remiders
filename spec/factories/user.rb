FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "some_user_#{n}@mail.ru" }
    password "some_user@mail.ru"
    first_name "Василий"
    last_name "Полено"
  end
end
