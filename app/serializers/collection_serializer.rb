class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :default

  has_many :sheets
end
