class EventsController < ApplicationController
  
  before_filter :require_login
  
  def index
    the_canvas_ids = current_user.canvas_user_roles.map{|cid| cid.canvas_id}
    @events = Event.where("canvas_id IN (?)",the_canvas_ids).order(:created_at).reverse_order.limit(5)
    u = current_user
    @notifications_viewed_at = u.notifications_viewed_at
    if @notifications_viewed_at.nil?
      @notifications_viewed_at = Time.now
    end
    u.notifications_viewed_at = Time.now
    u.save
    render :layout => false
  end
  
  def count
    the_canvas_ids = current_user.canvas_user_roles.map{|cid| cid.canvas_id}
    render :json => Event.where("canvas_id IN (?) AND created_at >= ?", the_canvas_ids, current_user.notifications_viewed_at).count()
  end
end
