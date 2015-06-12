class PlayerPreviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :receptions, :pos_rank, :age
end
