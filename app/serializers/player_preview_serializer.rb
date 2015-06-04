class PlayerPreviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :age
end
