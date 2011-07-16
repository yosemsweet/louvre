Given /^I am not authenticated$/ do
	Given "I go to 'sign out'"
end

When /^I am authenticated by facebook$/ do
	auth = request.env["omniauth.auth"]
end
