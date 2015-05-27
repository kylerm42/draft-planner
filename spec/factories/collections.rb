FactoryGirl.define do
  factory :collection do
    name "Test Ranks"
    user

    trait :default do
      default true
    end
  end
end
