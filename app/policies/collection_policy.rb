class CollectionPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(['"default" = true OR "user_id" = ?', user.id])
    end
  end
end
