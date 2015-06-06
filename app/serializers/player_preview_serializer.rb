class PlayerPreviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :pos_rank, :age
end
