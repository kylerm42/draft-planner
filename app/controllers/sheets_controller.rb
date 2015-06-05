class SheetsController < ApplicationController
  include Concerns::Authorization

  def show
    @record = Sheet.find_by(position: params[:position].upcase, collection_id: params[:collection_id])

    respond_with @record
  end

  private

    def permitted_params
      params.require(:sheet).permit(ranks: [])
    end

end
