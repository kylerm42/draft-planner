class CollectionsController < ApplicationController
  # include Concerns::Authorization

  def create
    p '============ before defining @resource'
    @resource = Collection.find(params[:collection][:dup_id])
                            .deep_dup(permitted_params.merge({ user: current_user,
                                                               default: false }))

    p '=============== after defining @resource, before respond_with'

    respond_with @resource
  end

  private

    def permitted_params
      params.require(:collection).permit(:name)
    end
end
