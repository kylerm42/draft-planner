class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :pos_rank, :birthdate, :age, :stats

  def stats
    object.attributes.select { |attr, val| Player.stat_keys.include?(attr.to_sym) }
  end

end
