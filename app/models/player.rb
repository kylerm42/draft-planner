class Player < ActiveRecord::Base
  # Validations
  validates_presence_of :name, :position, :points

  # Associations
  has_many :tags

  # Scopes
  scope :missing_from_sheet, -> sheet_id { where(position: Sheet.find(sheet_id).position).order(:name) - Sheet.find(sheet_id).players }

  def stats=(stats)
    self.attributes = stats
  end

  def set_age
    self.age = (Time.now.to_s(:number).to_i - birthdate.to_time.to_s(:number).to_i)/10e9.to_i
  end

  class << self

    def set_position_ranks(position)
      Player.transaction do
        players = Player.where(position: position).order(points: :desc)
        players.each_with_index do |player, idx|
          player.update(pos_rank: idx + 1)
        end
      end
    end

  def stat_keys
    [
      :pass_yards, :pass_tds, :pass_ints, :pass_comp, :pass_att, :fum_lost, :two_pt_conv, :fum_rec_td,
      :rush_att, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :made_pat, :miss_pat, :made_under20,
      :miss_under20, :made20s, :miss20s, :made30s, :miss30s, :made40s, :miss40s, :made50_plus,
      :miss50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :return_tds, :pts_allowed
    ]
  end

  end
end
