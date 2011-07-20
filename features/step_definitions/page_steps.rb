Then /^I should be the creator of the "([^"]*)" page$/ do |pagetitle|
  Page.find_by_title(pagetitle).creator.should == current_user
end

Then /^I should see a link to "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
