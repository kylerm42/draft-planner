module Concerns
  module ImplicitResource

    def index
      respond_with collection
    end

    def show
      respond_with record
    end

    def create
      record.save
      respond_with record
    end

    def update
      record.update(permitted_params)
      respond_with record
    end

    def destroy
      record.destroy
      render nothing: true
    end

    protected

      def klass
        @klass = controller_name.classify.constantize
      end

      def record
        @record ||= if params[:id].present?
          initialize_existing_record(params[:id])
        else
          initialize_new_record
        end
      end

      def collection
        @collection ||= if respond_to?(:policy_scope)
          policy_scope(apply_scopes(klass.all))
        else
          apply_scope(klass.all)
        end
      end

      def initialize_existing_record(id)
        klass.find(id)
      end

      def initialize_new_record
        klass.new(permitted_params).tap do |record|
          record.user = current_user if record.respond_to?(:user=)
        end
      end

      def collection_or_record
        params[:id] || action_name == 'create' ? record : collection
      end
  end
end
