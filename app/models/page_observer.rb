class PageObserver < ActiveRecord::Observer
  
  def after_create(page)
    description = "#{page.creator.name} added the #{page.title} page to the #{page.canvas.name} community"
		event = Event.create(:canvas_id => page.canvas_id, :user_id => page.creator_id, :loggable_id => page.id, :loggable_type => 'Page', :description => description)
  end

  def after_update(page)
    description = "#{page.creator.name} updated the #{page.title} page in the #{page.canvas.name} community"
		event = Event.create(:canvas_id => page.canvas_id, :user_id => @current_user, :loggable_id => page.id, :loggable_type => 'Page', :description => description)
  end

end
