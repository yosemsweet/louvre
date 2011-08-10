class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def require_login
    if !current_user
      redirect_to('/login', :notice => "Facebook sucks and logged you off.")
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

end
