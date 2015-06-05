class CollectionSerializer < ActiveModel::Serializer
  p '============== before attributes'
  attributes :id, :name, :default
  p '============= after attributes'

  # has_many :sheets
end
