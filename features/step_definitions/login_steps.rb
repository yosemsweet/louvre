Given /^I am not authenticated$/ do
	Given "I go to 'log out'"
end

Given /^I am authenticated$/ do
  Given "I log in with \"Facebook\""
end

Given /^I am "([^"]*)"$/ do |name|
	OmniAuth.config.mock_auth[:facebook] = {
    "provider"=>"facebook",
    "appid"=>"196297497094752",
		"app_secret" => "f2b1ddb79af75dbd498752f37fddc013", 
		"uid"=>"12345", 
    "user_info"=> {
				"image"=>"http://www.carniola.org/theglory/images/McHammer.gif", 
				"email"=>"test@xxxx.com", 
				"first_name"=>name.split[0], 
				"last_name"=>name.split[1],
				"name"=>name
			}
		}
 set_current_user( Factory.create(:user, :name => name) )
end

Given /^I am logged in$/ do
  @user = Factory.create(:user)
  set_current_user(@user)
end

When /^I log in with "([^"]*)"$/ do |provider|
	visit "/auth/#{provider.downcase}"
	set_current_user (that User)
end


Then /^I should be "([^"]*)"$/ do |name|
	current_user.name.should == name
end
