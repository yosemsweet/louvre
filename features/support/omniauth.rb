Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook",
      "appid"=>"196297497094752",
			"app_secret" => "f2b1ddb79af75dbd498752f37fddc013", 
			"uid"=>"12345", 
      "user_info"=> {
					"image"=>"http://www.carniola.org/theglory/images/McHammer.gif", 
					"email"=>"test@xxxx.com", 
					"first_name"=>"Test", 
					"last_name"=>"User", 
					"name"=>"Test User"
				}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end