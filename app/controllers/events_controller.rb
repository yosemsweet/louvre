class EventsController < ApplicationController
  
  before_filter :require_login
  
  def index
    @events = Event.where("canvas_id IN (?)",current_user.canvas_ids).order(:created_at).reverse_order.limit(5)
    u = current_user
    @notifications_viewed_at = u.notifications_viewed_at
    u.notifications_viewed_at = Time.now
    u.save
    render :layout => false
  end
  
  def count
    render :json => Event.where("canvas_id IN (?) AND created_at >= ?",  current_user.canvas_ids, current_user.notifications_viewed_at).count()
  end
end
