class BugPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.type == 'Qa'
  end

  def destroy?
    record.creator == user
  end

  def edit?
    record.creator == user
  end
end
