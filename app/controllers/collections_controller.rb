class CollectionsController < ApplicationController
  include Concerns::Authorization

  # Scopes
  has_scope :defualt, type: :boolean
  has_scope :user_id

  def index
    respond_with collection, each_serializer: CollectionPreviewSerializer
  end

  def create
    @record = Collection.find(params[:collection][:dup_id])
                          .deep_dup(permitted_params.merge({ user: current_user,
                                                             default: false }))

    respond_with @record
  end

  private

    def permitted_params
      params.require(:collection).permit(:name, :ppr)
    end
end
