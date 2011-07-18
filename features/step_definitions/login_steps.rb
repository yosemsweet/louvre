Given /^I am not authenticated$/ do
	Given "I go to 'sign out'"
end

Given /^I am authenticated$/ do
  Given "I sign in with \"Facebook\""
end


When /^I sign in with "([^"]*)"$/ do |provider|
	visit "/auth/#{provider.downcase}"
end
