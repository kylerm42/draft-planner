class SheetController < ApplicationController

  def show
    @resource = Sheet.find_by(position: params[:position].upcase, collection_id: params[:collection_id])

    respond_with @resource
  end

end
