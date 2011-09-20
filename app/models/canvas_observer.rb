class CanvasObserver < ActiveRecord::Observer

  def after_create(canvas)
  	event = Event.create(:canvas_id => canvas.id, :user_id => canvas.creator_id, :loggable_id => canvas.id, :loggable_type => 'Canvas', :description => 'Added a Canvas')
  end
  
  def after_update(canvas)
  		event = Event.create(:canvas_id => canvas.id, :user_id => @current_user, :loggable_id => canvas.id, :loggable_type => 'Canvas', :description => 'Updated a Canvas')
  end

end
