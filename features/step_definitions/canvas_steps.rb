Then /^I should own "([^"]*)" canvas$/ do |canvas_name|
	Canvas.find_by_name('Fashion of a Certain Age').owner = current_user
end

