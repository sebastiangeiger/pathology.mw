class PhysicianPolicy < ApplicationPolicy
  def create?
    user.admin? || user.pathologist?
  end
end
