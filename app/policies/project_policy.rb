class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.type == "Manager"
  end

  def edit?
    user.type == "Manager" and record.manager == user
  end

  def destroy?
    user.type == "Manager" and record.manager == user
  end
end
