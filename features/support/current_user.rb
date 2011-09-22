module KnowsCurrentUser
	def current_user
		if @current_user
		  @current_user
		else
		  email = Factory.create(:email)
		  @current_user = Factory.create(:user)
		  @current_user.emails << email
		  @current_user
		end
		@current_user
	end
	
	def set_current_user(user)
		@current_user = user
	end
end

World(KnowsCurrentUser)