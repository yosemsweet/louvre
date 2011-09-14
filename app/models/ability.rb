class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
  
    user ||= User.new # guest user (not logged in)
    can :read, :all  
    
    can :manage, Page do |page| 
      user.canvas_role?(page.canvas, :member)
    end
		
    can :manage, Widget do |widget| 
      user.canvas_role?(widget.canvas, :member)
    end
		
    can :manage, Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end    
    
    can :manage, CanvasApplicant do |canvas_applicant|  
      user.canvas_role?(canvas_applicant.canvas,:owner)
    end

  end
end
