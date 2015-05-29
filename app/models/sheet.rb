class Sheet < ActiveRecord::Base
  # Validations
  validates_presence_of     :position, :collection
  validates_uniqueness_of   :position, scope: :collection
  validate :ranked_players_match_sheet_position

  # Callbacks
  before_validation :ensure_int_ranks

  # Associations
  belongs_to :collection

  # Delegations
  delegate :user, to: :collection

  private

    def ranked_players_match_sheet_position
      unless (ranks - Player.where(position: position).map(&:id)).empty?
        errors.add(:ranks, "must only contain #{position}s")
      end
    end

    def ensure_int_ranks
      self.ranks = ranks.map(&:to_i)
    end
end
