class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user  
    
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
end
