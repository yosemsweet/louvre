module KnowsCurrentUser
	def current_user
		unless @current_user
			@current_user = Factory.create(:user)
			update_omniauth_defaults
		end
		@current_user
	end
	
	def set_current_user(user)
		@current_user = user
		update_omniauth_defaults
	end
	
	private
	
	def update_omniauth_defaults
		OmniAuth.config.mock_auth[:facebook] = {
	    "provider"=>"facebook",
	    "appid"=>"196297497094752",
			"app_secret" => "f2b1ddb79af75dbd498752f37fddc013", 
			"uid"=>@current_user.uid, 
	    "user_info"=> {
					"image"=>@current_user.image, 
					"email"=>@current_user.primary_email, 
					"first_name"=>@current_user.name.split[0], 
					"last_name"=>@current_user.name.split[1],
					"name"=>@current_user.name
				}
			}
		
		@current_user
	end
end

World(KnowsCurrentUser)