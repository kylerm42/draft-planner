class TagSerializer < ActiveModel::Serializer
  attributes :id, :sheet_id, :player_id, :sleeper, :bust, :injury, :notes, :removed
end
