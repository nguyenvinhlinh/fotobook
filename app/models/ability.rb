class Ability
  include CanCan::Ability
  def initialize(user)
    alias_action :loadAjaxAllImage, to: :ajax
    alias_action :ac_by_tag, to: :autocomplete_tag
    user ||= User.new 
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, [Tag, Picture]
    else
      can [:read, :ajax], Picture
      can [:autocomplete_tag, :read], Tag
    end
  end
end
