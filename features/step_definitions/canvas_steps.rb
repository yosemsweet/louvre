Given /^there is a canvas$/ do
  set_that Factory.create(:canvas)
end

Given /^I am a member of (\d+) canvae$/ do |number|
  canvas_list = Factory.create_list(:canvas, number.to_i )
  canvas_list.each do |c|
    (current_user).set_canvas_role(c, :member)
  end
end

Given /^I am the owner of a canvas$/ do
  set_that Factory.create(:canvas, :creator => current_user)
end

Given /^I am the owner of (\d+) canvae$/ do |number|
  canvas_list = Factory.create_list(:canvas, number.to_i, :creator => current_user)
  set_that canvas_list.last
end

Given /^(?:this|that) canvas has a page (?:titled|called) "([^"]*)"$/ do |pagetitle|
	page_prototype = Factory.build(:page, :title => pagetitle).attributes.except(
		"created_at", "updated_at", "page_id", "canvas_id", "id")
  page = (that Canvas).pages.create(page_prototype)
	set_that page
end

Given /^I am creating a canvas$/ do
  visit path_to("the new canvas page")
	canvas = Factory.build(:canvas)
	fill_in("Name", :with => canvas.name)
	fill_in("Image", :with => canvas.image)
end

Given /^(?:I have|I've) created a new canvas$/ do
	visit path_to("the new canvas page")
end

Given /^that canvas is closed$/ do
  (that Canvas).open = false
end

When /^I specify that canvas should be "([^"]*)"$/ do |state|
	if state == "open"
		page.check("canvas[open]")
	else
		page.uncheck("canvas[open]")
	end
end

Then /^I should be the creator of the "([^"]*)" canvas$/ do |canvas_name|
	Canvas.find_by_name(canvas_name).creator.should == current_user
end

Then /^the "([^"]*)" should be filled with "([^"]*)"$/ do |field_name, field_value|
  find_field(field_name).value.should == field_value
end

Then /^I should see any ongoing discussions for that canvas$/ do
	page.should have_selector("#discussions")
end

Given /^I should see the feed$/ do
  should have_html("<ul id='feed'>")
end

Then /^that canvas should have a random name starting with "([^"]*)"$/ do |name|
  (that Canvas).name.start_with?(name).should be_true
end

Then /^that canvas should be named "([^"]*)"$/ do |name|
  (that Canvas).name.should == name
end

Then /^that canvas should have an example widget$/ do
  Widget.for_canvas((that Canvas), 0).should_not be_empty
end

Then /^I should be an owner of those (\d+) canvae$/ do |number|
  Canvas.last(2).each do |c|
    c.creator.should == current_user
  end
end

