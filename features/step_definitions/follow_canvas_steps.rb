Then /^I should be following$/ do
	current_user.following_by_type_count('Canvas').should == 1
end

Then /^I should not be following$/ do
  current_user.following_by_type_count('Canvas').should == 0
end