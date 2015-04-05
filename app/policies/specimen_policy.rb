class SpecimenPolicy < ApplicationPolicy
  def create?
    user.admin? || user.pathologist?
  end

  def update?
    user.admin? || user.pathologist?
  end
end
