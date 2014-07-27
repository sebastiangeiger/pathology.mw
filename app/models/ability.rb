class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    alias_action :create, :read, :update, to: :cru

    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    end

    if user.pathologist?
      can :cru, Patient
      can :cru, ClinicalHistory
    end

  end
end
