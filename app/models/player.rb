class Player < ActiveRecord::Base
  # Validations
  validates_presence_of :name, :position, :points

  # Associations
  has_many :tags

  # Scopes
  scope :missing_from_sheet, -> sheet_id { where(position: Sheet.find(sheet_id).position).order(:name) - Sheet.find(sheet_id).players }
end
