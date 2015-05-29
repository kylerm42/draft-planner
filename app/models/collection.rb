class Collection < ActiveRecord::Base
  # Validations
  validates :name, presence: true, uniqueness: { scope: :user }

  # Associations
  belongs_to :user
  has_many   :sheets

end
