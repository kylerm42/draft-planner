class PlayersController < ApplicationController
  has_scope :missing_from_sheet

  def index
    respond_with collection, each_serializer: PlayerPreviewSerializer
  end

  def create
    record.set_age
    record.save
    Player.set_position_ranks(record.position)

    respond_with record
  end

  def update
    record.set_age
    record.update(permitted_params)
    Player.set_position_ranks(record.position)

    respond_with record
  end

  private

    def permitted_params
      params.require(:player).permit(:name, :position, :team, :birthdate, :points, stats: Player.stat_keys)
    end
end
