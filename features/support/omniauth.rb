Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook",
      "appid"=>"178863089564",
			"app_secret" => "5df447b8480c97b38307cae54e1627c0", 
      "user_info"=>{"email"=>"test@xxxx.com", "first_name"=>"Test", "last_name"=>"User", "name"=>"Test User"}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end