class Collection < ActiveRecord::Base
  # Validations
  validates :name, presence: true, uniqueness: { scope: :user }

  # Associations
  belongs_to :user
  has_many   :sheets, dependent: :destroy

  # Scopes
  scope :defualt, -> { where(default: true) }
  scope :user_id, -> user_id { where(user_id: user_id) }

  def deep_dup(options = {})
    dup.tap do |kopy|
      kopy.attributes = options

      Collection.transaction do
        kopy.save

        sheets.each do |sheet|
          kopy.sheets << sheet.dup
        end

        kopy.sheets.each { |sheet| sheet.save }
      end
    end
  end

end
