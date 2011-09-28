Given /^I am not authenticated$/ do
	Given "I go to 'log out'"
end

Given /^I am authenticated$/ do
  Given "I log in with \"Facebook\""
end

Given /^I am "([^"]*)"$/ do |name|
	set_current_user(Factory.create(:user, :name => name))
end

When /^I log in with "([^"]*)"$/ do |provider|
	current_user
	visit "/auth/#{provider.downcase}"
end

Then /^I should be "([^"]*)"$/ do |name|
	current_user.name.should == name
end

Then /^I should see my name$/ do
	unless current_url == ""
		Then %Q(I should see "#{current_user.name}" within the user details) 
	end
end
