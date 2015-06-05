class CollectionPolicy < ApplicationPolicy
  def show?
    p '============ before owned?'
    owned?
    p '============= after owned?'
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user
        scope.where(['"default" = true OR "user_id" = ?', user.id])
      else
        scope
      end
    end
  end

  private

    def owned?
      record.user == user
    end
end
