class EventsController < ApplicationController
  def index
    @events = Event.all
    render :layout => false
  end
  
  def count
    render :json => Event.count()
  end
end
