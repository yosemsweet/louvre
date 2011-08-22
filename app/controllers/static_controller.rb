class StaticController < ApplicationController

	def index
		redirect_to "http://welcome.loorp.com/collaborate"
		#@recent_canvases = Canvas.recently_updated(10)
	end

  def login
		session[:return_to] = request.referer
    render :layout => 'basic'
  end

end 
