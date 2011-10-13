class ApplicationController < ActionController::Base
  helper_method :current_user
  
  before_filter :initialize_mixpanel
  before_filter :update_last_action
  
  rescue_from CanCan::AccessDenied do |exception|
    render :status => :forbidden, :text => "You don't have permissions for that action. #{exception}"
  end
  
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

  def update_last_action
    if current_user
      current_user.last_action = DateTime.now
      current_user.can_email = 1
      current_user.save
    end
  end

  def initialize_mixpanel
    @mixpanel = Mixpanel::Tracker.new(MIXPANEL_CONFIG[:token], request.env, true)
  end

end
