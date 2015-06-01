module Concerns
  module ImplicitResource

    def index
      respond_with collection
    end

    def show
      respond_with resource
    end

    def create
      resource.save
      respond_with resource
    end

    def update
      resource.update(permitted_params)
      respond_with resource
    end

    def destroy
      resource.destroy
      render nothing: true
    end

    protected

      def klass
        @klass = controller_name.classify.constantize
      end

      def resource
        @resource ||= if params[:id].present?
          initialize_existing_resource(params[:id])
        else
          initialize_new_resource
        end
      end

      def collection
        @collection = policy_scope(klass.all)
        # @collection ||= if respond_to?(:policy_scope)
        #   policy_scope(apply_scopes(klass.all))
        # else
        #   apply_scopes(klass.all)
        # end
      end

      def initialize_existing_resource(id)
        klass.find(id)
      end

      def initialize_new_resource
        klass.new(permitted_params).tap do |record|
          record.user = current_user if record.respond_to?(:user=)
        end
      end
  end
end
