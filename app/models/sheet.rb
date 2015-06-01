class Sheet < ActiveRecord::Base
  # Validations
  validates_presence_of     :position, :collection
  validates_uniqueness_of   :position, scope: :collection
  validate :ranked_players_match_sheet_position

  # Associations
  belongs_to :collection

  # Delegations
  delegate :user, to: :collection

  def players
    Player.where(id: ranks)
  end

  private

    def ranked_players_match_sheet_position
      unless (ranks - Player.where(position: position).map(&:id)).empty?
        errors.add(:ranks, "must only contain #{position}s")
      end
    end
end
