FactoryGirl.define do
  factory :player do
    name { Faker::Name.name }
    position { %w(QB RB WR TE DEF K).sample }
    points 150.00
  end

  %w(QB RB WR TE DEF K).each do |pos|
    trait pos.downcase.to_sym do
      position pos
    end
  end
end
