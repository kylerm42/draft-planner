class SheetSerializer < ActiveModel::Serializer
  attributes :id, :position, :ranks

  has_many :players, serializer: PlayerPreviewSerializer
  has_many :tags
end
