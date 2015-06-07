class Player < ActiveRecord::Base
  # Validations
  validates_presence_of :name, :position, :points, :points_ppr

  # Associations
  has_many :tags
end
