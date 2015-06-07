class PlayerPreviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :pos_rank, :age

  # has_many :tags
end
