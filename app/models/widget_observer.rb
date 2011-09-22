class WidgetObserver < ActiveRecord::Observer
  include ApplicationHelper
  
  def after_create(widget)
    if widget.page.nil?
      description = "#{widget.creator.name} added #{indefinite_articlerize(widget.content_type.split('_').first)} widget to the #{widget.canvas.name} community feed"
    else
      description = "#{widget.creator.name} added #{indefinite_articlerize(widget.content_type.split('_').first)} widget to the #{widget.page.title} page in the #{widget.canvas.name} community"
    end

  	event = Event.create(:canvas_id => widget.canvas_id, :user_id => widget.creator_id, :loggable_id => widget.id, :loggable_type => 'Widget', :description => description)
  end
  
  def after_update(widget)
    if widget.position.nil? || widget.position_changed?
  	  if widget.page.nil?
        description = "#{widget.creator.name} updated #{indefinite_articlerize(widget.content_type.split('_').first)} widget in the #{widget.canvas.name} community feed"
      else
        description = "#{widget.creator.name} updated #{indefinite_articlerize(widget.content_type.split('_').first)} widget on the #{widget.page.title} page in the #{widget.canvas.name} community"
      end
  	  event = Event.create(:canvas_id => widget.canvas_id, :user_id => widget.creator_id, :loggable_id => widget.id, :loggable_type => 'Widget', :description => description)
	  end
  end
end
