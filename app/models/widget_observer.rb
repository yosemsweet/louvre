class WidgetObserver < ActiveRecord::Observer

  def after_create(widget)
  	event = Event.create(:canvas_id => widget.canvas_id, :user_id => widget.creator_id, :loggable_id => widget.id, :loggable_type => 'Widget', :description => 'Added a Widget')
  end
  
  def after_update(widget)
  	event = Event.create(:canvas_id => widget.canvas_id, :user_id => widget.creator_id, :loggable_id => widget.id, :loggable_type => 'Widget', :description => 'Updated a Widget')
  end

end
