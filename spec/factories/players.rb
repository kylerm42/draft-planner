FactoryGirl.define do
  factory :player do
    name Faker::Name
    position 'RB'
    points 150.00
    points_ppr 174.50
  end

  trait :qb do
    position 'QB'
  end

  trait :wr do
    position 'WR'
  end

  trait :te do
    position 'TE'
  end

  trait :def do
    position 'DEF'
  end

  trait :k do
    position 'K'
  end
end
