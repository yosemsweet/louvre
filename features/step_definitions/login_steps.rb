Given /^I am not authenticated$/ do
	Given "I go to 'sign out'"
end

Given /^I sign in with "([^"]*)"$/ do |provider|
	
end

Given /^I am signed in with "([^"]*)"$/ do |provider|
  visit "/auth/#{provider.downcase}"
	Then "I should see \"Signed in\""
end

Given /^I am logged ([^"]*)$/ do |logged_in_state|
	Then "I should see \"Test User\""
end