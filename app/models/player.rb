class Player < ActiveRecord::Base
  # Validations
  validates_presence_of :name, :position, :points

  # Associations
  has_many :tags
end
