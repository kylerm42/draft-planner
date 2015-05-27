class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string    :name,          null: false
      t.string    :position,      null: false
      t.string    :team
      t.decimal   :points,        null: false, precision: 6, scale: 2, default: 0.0
      t.decimal   :points_ppr,    null: false, precision: 6, scale: 2, default: 0.0
      t.date      :birthdate
      t.integer   :age
      t.integer   :pass_comp,     default: 0
      t.integer   :pass_att,      default: 0
      t.integer   :pass_yards,    default: 0
      t.integer   :pass_tds,      default: 0
      t.integer   :pass_ints,     default: 0
      t.integer   :rush_att,      default: 0
      t.integer   :rush_yards,    default: 0
      t.integer   :rush_tds,      default: 0
      t.integer   :receptions,    default: 0
      t.integer   :rec_yards,     default: 0
      t.integer   :rec_tds,       default: 0
      t.integer   :fum_lost,      default: 0
      t.integer   :two_pt_conv,   default: 0
      t.integer   :fum_rec_td,    default: 0

      t.integer   :made_pat,      default: 0
      t.integer   :miss_pat,      default: 0
      t.integer   :made_0_19,     default: 0
      t.integer   :miss_0_19,     default: 0
      t.integer   :made_20_29,    default: 0
      t.integer   :miss_20_29,    default: 0
      t.integer   :made_30_39,    default: 0
      t.integer   :miss_30_39,    default: 0
      t.integer   :made_40_49,    default: 0
      t.integer   :miss_40_49,    default: 0
      t.integer   :made_50_plus,  default: 0
      t.integer   :miss_50_plus,  default: 0

      t.integer   :sacks,         default: 0
      t.integer   :interceptions, default: 0
      t.integer   :fum_rec,       default: 0
      t.integer   :safeties,      default: 0
      t.integer   :def_tds,       default: 0
      t.integer   :return_tds,    default: 0
      t.integer   :pts_allowed,   default: 0

      t.timestamps                null: false
    end

    add_index :players, :position
  end
end
