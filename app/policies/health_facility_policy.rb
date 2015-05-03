class HealthFacilityPolicy < ApplicationPolicy
  def create?
    user.admin? || user.pathologist?
  end
end
