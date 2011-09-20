class PageObserver < ActiveRecord::Observer

  def after_create(page)
		event = Event.create(:canvas_id => page.canvas_id, :user_id => page.creator_id, :loggable_id => page.id, :loggable_type => 'Page', :description => 'Added a Page')
  end

  def after_update(page)
		event = Event.create(:canvas_id => page.canvas_id, :user_id => @current_user, :loggable_id => page.id, :loggable_type => 'Page', :description => 'Updated a Page')
  end

end
