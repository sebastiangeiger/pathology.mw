class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, User
    end
    can :manage, Patient
  end
end
