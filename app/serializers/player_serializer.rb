class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :team, :points, :points_ppr, :pos_rank, :birthdate, :age, :stats

  def stats
    categories = if object.position == 'DEF'
      [:sacks, :interceptions, :fum_rec, :safeties, :def_tds, :return_tds, :pts_allowed]
    elsif object.position == 'K'
      [:made_pat, :miss_pat, :made_0_19, :miss_0_19, :made_20_29, :miss_20_29, :made_30_39, :miss_30_39, :made_40_49, :miss_40_49, :made_50_plus, :miss_50_plus]
    else
      [:pass_comp, :pass_att, :pass_yards, :pass_tds, :pass_ints, :rush_att, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds,:fum_lost, :two_pt_conv, :fum_rec_td]
    end

    object.attributes.select { |attr, val| categories.include?(attr.to_sym)}
  end

end
