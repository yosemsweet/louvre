class SessionsController < ApplicationController
	
	def create
		session[:return_to] = session[:redirect] || request.referer
		session[:redirect] = nil
		auth = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth) 
		session[:user_id] = user.id  
    redirect_to session[:return_to], :notice => "Logged in."
	end
	
	def destroy  
	  session[:user_id] = nil  
	  redirect_to request.referer, :notice => "Logged out."  
	end
end
