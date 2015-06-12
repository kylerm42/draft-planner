class SheetsController < ApplicationController
  include Concerns::Authorization

  # Scopes
  has_scope :by_position
  has_scope :by_collection_id

  private

    def permitted_params
      params.require(:sheet).permit(ranks: [])
    end

end
