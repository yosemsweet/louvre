Given /^I am not authenticated$/ do
	Given "I go to 'sign out'"
end

Given /^I sign in with "([^"]*)"$/ do |provider|
	
end

Given /^I am signed in with "([^"]*)"$/ do |provider|
  visit "/auth/#{provider.downcase}"
end
