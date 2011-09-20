class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
  
    user ||= User.new # guest user (not logged in)
    can :read, :all  
    
    can :apply, Canvas do |canvas|
      user.persisted? && !user.canvas_role?(canvas,:member) && user.canvas_role(canvas) != :banned
    end
    
    can :create, CanvasUserRole do |canvas_user_role|
      if canvas_user_role.canvas.closed?
        user.canvas_role?(canvas_user_role.canvas, :owner)
      else
        user.id == canvas_user_role.user.id
      end
    end
    
    can :manage, Page do |page| 
      user.canvas_role?(page.canvas, :member)
    end
		
    can :manage, Widget do |widget| 
      user.canvas_role?(widget.canvas, :member)
    end
		
    can :create, Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end    

    can :update, Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end    
    
    can :delete, Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end
    
    can :manage, CanvasApplicant do |canvas_applicant|  
      user.canvas_role?(canvas_applicant.canvas,:owner)
    end

		can :make_admin, User	if user.admin == true
  end
end
