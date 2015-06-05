module Concerns
  module Authorization
    extend ActiveSupport::Concern

    included do
      include Pundit

      rescue_from Pundit::NotAuthorizedError do
        render json: { error: "insufficient_privileges" },
          status: :forbidden
      end

      before_action :authorize_resource
    end

    def authorize_resource
      authorize collection_or_resource
    end
  end
end
