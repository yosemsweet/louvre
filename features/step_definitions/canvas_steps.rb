Then /^I should be the creator of the "([^"]*)" canvas$/ do |canvas_name|
	Canvas.find_by_name(canvas_name).creator.should == current_user
end

