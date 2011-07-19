module KnowsCurrentUser
	def current_user
		@current_user ||= Factory.create(:user) 
	end
	
	def set_current_user(user)
		@current_user = user
	end
end

World(KnowsCurrentUser)