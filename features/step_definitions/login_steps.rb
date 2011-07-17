Given /^I am not authenticated$/ do
	Given "I go to 'sign out'"
end

When /^I am authenticated by facebook$/ do
	visit 'auth/facebook/callback'
end
