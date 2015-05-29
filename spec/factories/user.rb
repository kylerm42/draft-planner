FactoryGirl.define do
  factory :user do
    provider 'email'
    email { Faker::Internet.email }
    password 'test1234'
  end
end
