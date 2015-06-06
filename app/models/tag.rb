class Tag < ActiveRecord::Base

  # Associations
  belongs_to :sheet
  belongs_to :player
end
