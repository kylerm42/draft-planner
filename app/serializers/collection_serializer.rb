class CollectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :default, :ppr

  has_many :sheets
end
