class StaticController < ApplicationController

	def index
		@recent_canvases = Canvas.recently_updated(10)
	end
	
  def login
    render :layout => 'basic'
  end

end
