class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if !user
        scope.all
      elsif user.type == 'Developer'
        scope.joins(:developers).where("projects_developers.developer_id = #{user.id}")
      else
        scope.all
      end
    end
  end

  def create?
    user.type == 'Manager'
  end

  def edit?
    user.type == 'Manager' and record.manager == user
  end

  def destroy?
    user.type == 'Manager' and record.manager == user
  end

  def add_user?
    user.type == 'Manager' and record.manager == user
  end

  def remove_user?
    user.type == 'Manager' and record.manager == user
  end
end
