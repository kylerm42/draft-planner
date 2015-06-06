class TagPolicy < ApplicationPolicy
  def create?
    owned?
  end

  def update?
    owned?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      user ? super.where(user_id: user.id) : super.none
    end
  end

  private

    def owned?
      record.sheet.user == user
    end
end
