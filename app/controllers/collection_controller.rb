class CollectionController < ApplicationController

  def create
    @resource = Collection.find(params[:collection][:dup_id])
                            .deep_dup(permitted_params.merge({ user: User.first,
                                                               default: false }))

    respond_with @resource
  end

  private

    def permitted_params
      params.require(:collection).permit(:name)
    end
end
