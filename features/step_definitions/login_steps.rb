Given /^I am not authenticated$/ do
	Given "I go to 'log out'"
end

Given /^I am authenticated$/ do
  Given "I log in with \"Facebook\""
end


When /^I log in with "([^"]*)"$/ do |provider|
	visit "/auth/#{provider.downcase}"
	set_current_user (that User)
end
