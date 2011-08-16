Given /^there is a canvas$/ do
  Factory.create(:canvas)
end

Then /^the page title should be "([^"]*)"$/ do |title|
  within("title") do 
    page.should have_content(title)
  end
end

Given /^I am "([^"]*)"$/ do |name|
 set_current_user( Factory.create(:user, :name => name) )
end

Given /^I am logged in$/ do
  @user = Factory.create(:user)
  set_current_user(@user)
end

Given /^this canvas has a page titled "([^"]*)"$/ do |pagetitle|
  page = Factory.create(:page, :title => pagetitle, :canvas => Canvas.last)
end

When /^(?:|I )reload the page$/ do
  visit(current_path)
end

When /^I wait (\d+) second[s?]$/ do |n|
	sleep n.to_i
end


Then /^I see the "([^"]*)" dialog$/ do |dialog|
	page.should have_content(dialog)
end

Then /^(?:|I )should see the "([^"]*)" button$/ do |text|
  button_is_visible = page.has_button?(text) && page.find_button(text).visible?
  button_is_visible.should == true
end

Then /^(?:|I )should not see the "([^"]*)" button$/ do |text|
  button_is_visible = page.has_button?(text) && page.find_button(text).visible?  
  button_is_visible.should == false
end

Then /^I see the page$/ do
	puts page.html
end
