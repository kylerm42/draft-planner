class CollectionController < ApplicationController

  def create
    @collection = Collection.find(params[:dup_id])
                            .deep_dup(permitted_params.merge({ user: User.first }))

    render json: @collection
  end

  private

    def permitted_params
      params.require(:collection).permit(:name)
    end
end
