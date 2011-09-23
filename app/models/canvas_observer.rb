class CanvasObserver < ActiveRecord::Observer

  def after_create(canvas)
  	description = "#{canvas.editor.name} created the #{canvas.name} community"
  	event = Event.create(:canvas_id => canvas.id, :user_id => canvas.creator_id, :loggable_id => canvas.id, :loggable_type => 'Canvas', :description => description)
  end
  
  def after_update(canvas)
  	description = "#{canvas.editor.name} updated the #{canvas.name} community"
  	event = Event.create(:canvas_id => canvas.id, :user_id => @current_user, :loggable_id => canvas.id, :loggable_type => 'Canvas', :description => description)
  end

end
