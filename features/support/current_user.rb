module KnowsCurrentUser
	def current_user
		@current_user ||= Factory.create(:user) 
	end
end

World(KnowsCurrentUser)