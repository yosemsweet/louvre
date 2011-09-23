Then /^I should be the creator of the "([^"]*)" page$/ do |pagetitle|
  Page.find_by_title(pagetitle).creator.should == current_user
end
