class Sheet < ActiveRecord::Base
  # Validations
  validates_presence_of     :position, :collection
  validates_uniqueness_of   :position, scope: :collection

  # Associations
  belongs_to :collection

  # Delegations
  delegate :user, to: :collection
end
