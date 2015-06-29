class SheetSerializer < ActiveModel::Serializer
  attributes :id, :position, :ranks

  has_many :players

  def players
    sorted_players = []
    players = object.players
    tags = object.tags.to_a

    object.ranks.each do |player_id|
      player = players.select { |p| p.id == player_id }.first
      tag = tags.select { |t| t.player_id == player_id }.first || {}
      sorted_players << player.attributes.merge({ 'tag' => tag })
    end

    sorted_players
  end
end
