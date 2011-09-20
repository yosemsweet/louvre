class EventsController < ApplicationController
  def index
    @events = Event.where(:canvas_id => current_user.canvas_ids).order(:created_at).reverse_order.limit(5)
    u = current_user
    @notifications_viewed_at = u.notifications_viewed_at
    u.notifications_viewed_at = Time.now
    u.save
    render :layout => false
  end
  
  def count
    render :json => Event.where("canvas_id = ? AND created_at >= ?",  current_user.canvas_ids, current_user.notifications_viewed_at).count()
  end
end
