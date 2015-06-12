class SheetPolicy < ApplicationPolicy
  def show?
    home? || (authenticated? && owned?)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user
        scope.joins(:collection).where('collections.user_id' => user.id)
      else
        scope
      end
    end
  end

  private

    def owned?
      record.collection.user == user
    end

    def home?
      record.collection.id == 1
    end
end
