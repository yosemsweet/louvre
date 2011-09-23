class CanvasUserRoleObserver < ActiveRecord::Observer
  include ApplicationHelper
  
  def after_create(canvas_user_role)
    description = "#{canvas_user_role.user.name} is now #{indefinite_articlerize(canvas_user_role.role)} of the #{canvas_user_role.canvas.name} community"
    event = Event.create(:canvas_id => canvas_user_role.canvas_id, :user_id => canvas_user_role.canvas.creator_id, :loggable_id => canvas_user_role.canvas_id, :loggable_type => 'Canvas', :description => description)
  end
  def after_update(canvas_user_role)
    description = "#{canvas_user_role.user.name} is now #{indefinite_articlerize(canvas_user_role.role)} of the #{canvas_user_role.canvas.name} community"
    event = Event.create(:canvas_id => canvas_user_role.canvas_id, :user_id => canvas_user_role.canvas.creator_id, :loggable_id => canvas_user_role.canvas_id, :loggable_type => 'Canvas', :description => description)
  end

end
