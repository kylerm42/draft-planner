FactoryGirl.define do
  factory :sheet do
    position { %w(QB RB WR TE DEF K).sample }
    collection

    ranks do
      arr = []
      10.times { arr << create(:player, position.downcase.to_sym).id }
      arr
    end
  end
end
