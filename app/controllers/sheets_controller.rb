class SheetsController < ApplicationController
  # include Concerns::Authorization

  def show
    @resource = Sheet.find_by(position: params[:position].upcase, collection_id: params[:collection_id])

    respond_with @resource
  end

  private

    def permitted_params
      params.require(:sheet).permit(ranks: [])
    end

end
