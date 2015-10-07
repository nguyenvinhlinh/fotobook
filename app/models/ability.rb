class Ability
  include CanCan::Ability
  def initialize(user)
    alias_action :loadAjaxAllImage, to: :ajax
    user ||= User.new 
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, [Tag, Picture]
    else
      can [:read, :ajax], Picture
    end
  end
end
