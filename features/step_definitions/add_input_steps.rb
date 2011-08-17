Then /^I should see the new widget form$/ do 
	page.should have_selector("#inline_form .widget")
end
