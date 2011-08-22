class StaticController < ApplicationController

	def index
  if Rails.env.production?
		  redirect_to "http://welcome.loorp.com/collaborate"
		else
		  @recent_canvases = Canvas.recently_updated(10)
		end
	end

  def login
		session[:return_to] = request.referer
    render :layout => 'basic'
  end

end 
