class PatientPolicy < ApplicationPolicy
  def index?
    user.admin? || user.pathologist? || user.physician?
  end

  def create?
    user.admin? || user.pathologist?
  end

  def update?
    user.admin? || user.pathologist?
  end
end
