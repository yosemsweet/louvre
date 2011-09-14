class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    can :read, :all  
    
    can :manage, Page do |page| 
       canvas = page.canvas
      # Only members can manage pages of closed canvases.
      if canvas.closed?
        user.canvas_role?(canvas, :member)
      # Any logged in users can manage pages of open canvases.
      else
        user.canvas_role?(canvas, :user)
      end
    end
    
    can :manage, Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end    
    
    can :manage, CanvasApplicant do |canvas_applicant|  
      user.canvas_role?(canvas_applicant.canvas,:owner)
    end
    
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
