class PlayersController < ApplicationController
  has_scope :missing_from_sheet

  def index
    respond_with collection, each_serializer: PlayerPreviewSerializer
  end
end
