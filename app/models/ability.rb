class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
  
    user ||= User.new # guest user (not logged in)
    can :read, :all    
    can :view_hint, nil

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
    
    can [:read, :create, :update, :destroy], Page do |page| 
      user.canvas_role?(page.canvas, :member)
    end
		
    can [:read, :create, :update, :destroy], Widget do |widget| 
      user.canvas_role?(widget.canvas, :member)
    end
		
    can [:read, :create, :update, :destroy], Canvas do |canvas|  
      user.canvas_role?(canvas,:owner)
    end    

    can [:read, :create, :update, :destroy], CanvasApplicant do |canvas_applicant|  
      user.canvas_role?(canvas_applicant.canvas,:owner)
    end

		can :make_admin, User	if user.admin == true
		
    can :view_hint, Canvas do |canvas|
      canvas.creator == user && canvas.created_at == canvas.updated_at && user.canvae.count == 1
    end
    
    can :view_page_hint, Page do |page|
      page.canvas.creator == user && page.canvas.pages.count == 0 && page.created_at == page.updated_at && user.canvae.count == 1
    end
  
    can :view_hint, Widget do |widget| 
      widget.canvas.creator == user && widget.canvas.widgets.count <= 1 && widget.created_at == widget.updated_at && user.canvae.count == 1
    end
    
  end
end
