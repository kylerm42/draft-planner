class Sheet < ActiveRecord::Base
  # Validations
  validates_presence_of     :position, :collection
  validates_uniqueness_of   :position, scope: :collection
  validate :ranked_players_match_sheet_position

  # Callbacks
  before_save :remove_rank_duplicates

  # Associations
  belongs_to :collection
  has_many   :tags

  # Delegations
  delegate :user, to: :collection

  # Scopes
  scope :by_position, -> position { where(position: position) }
  scope :by_collection_id, -> collection_id { where(collection_id: collection_id) }

  def players
    Player.where(id: ranks)
  end

  private

    def ranked_players_match_sheet_position
      unless (ranks - Player.where(position: position).map(&:id)).empty?
        errors.add(:ranks, "must only contain #{position}s")
      end
    end

    def remove_rank_duplicates
      self.ranks = ranks.uniq
    end
end
