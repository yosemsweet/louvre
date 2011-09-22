class EventObserver < ActiveRecord::Observer

  def after_create(event)
    c = event.canvas
		c.user_roles.each do |cu|
		  u = cu.user
		  #if u.last_action < 1.hour.ago && u.can_email == 1
        UserMailer.notifications_email(u,event).deliver
		    u.can_email = 0
		    u.save
		  #end
		end
		
  end

end
