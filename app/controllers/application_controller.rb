class ApplicationController < ActionController::Base
  helper_method :current_user
  
  before_filter :initialize_mixpanel
  
  add_breadcrumb "Home", :root_path

  def require_login
    if !current_user
      session[:redirect] = request.url
      redirect_to('/auth/facebook', :notice => "Facebook sucks and logged you off.")
    end
  end
    
  private  
  def current_user  
	
		if session[:user_id] && User.exists?(session[:user_id])
    	@current_user ||= User.find(session[:user_id])
		else
			session[:user_id] = nil
			@current_user = nil
		end
		
		return @current_user
		
  end
  
  def add_canvas_breadcrumb(canvas)
    add_breadcrumb canvas.name, canvas_path(canvas)
  end
  
  def add_page_breadcrumb(page)
		add_breadcrumb page.title, canvas_page_path(page.canvas, page)
  end

  def initialize_mixpanel
    @mixpanel = Mixpanel::Tracker.new(MIXPANEL_CONFIG[:token], request.env, true)
  end

end
