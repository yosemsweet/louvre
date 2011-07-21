Then /^I should be the creator of the "([^"]*)" canvas$/ do |canvas_name|
	Canvas.find_by_name(canvas_name).creator.should == current_user
end

Then /^the "([^"]*)" should be filled with "([^"]*)"$/ do |field_name, field_value|
  find_field(field_name).value.should == field_value
end
