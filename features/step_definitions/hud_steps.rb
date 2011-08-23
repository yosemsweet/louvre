Then /^I should see the hud$/ do
	page.should have_selector("#hud")
  page.find("#hud").should be_visible
end

Then /^I should see that canvas' name in the hud$/ do
  within('#hud') do
    page.should have_content(Canvas.last.name)
  end
end

