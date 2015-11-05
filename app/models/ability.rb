class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :manage, :all
    else
      can :update, Company do |company|
        # если юзер является Овнером этой компании
        company.company_users.where(owner: true, user_id: user.id).count > 0
      end
      can :destroy, Company do |company|
        company.company_users.where(owner: true, user_id: user.id).count > 0
      end
      can :create, Company
    end
  end
end
