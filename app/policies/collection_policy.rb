class CollectionPolicy < ApplicationPolicy
  def show?
    owned?
  end

  def index?
    true
  end

  def update?
    owned?
  end

  def destroy?
    owned?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user
        super.where(['"default" = true OR "user_id" = ?', user.id])
      else
        super.where(default: true)
      end
    end
  end

  private

    def owned?
      record.user == user
    end
end
