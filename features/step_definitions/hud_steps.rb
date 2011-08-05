# Given /^I am following that canvas$/ do 
#   current_user.followed_canvae << Canvas.last
#   current_user.save
# end
# 
# Then /^I should see that canvas' name$/ do
#   page.should have_content(Canvas.last.name)
# end

Then /^I should see the hud$/ do
  page.find("#hud").should be_visible
end

Then /^I should see that canvas' name in the hud$/ do
  within('#hud') do
    page.should have_content(Canvas.last.name)
  end
end

