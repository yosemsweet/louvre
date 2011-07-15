Then /^I should see the logo$/ do
  page.should have_css('#logo')
end

Then /^I should see an intro video$/ do
  page.should have_css('#intro_video')
end