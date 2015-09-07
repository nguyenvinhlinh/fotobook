class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, [Tag, Picture]
    else
      can :read, Picture
    end
  end
end
