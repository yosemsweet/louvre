Given /^there is a canvas$/ do
  set_that Factory.create(:canvas)
end

Given /^I am a member of (\d+) canvae$/ do |number|
  set_that that(User)
  canvas_list = Factory.create_list(:canvas, number.to_i )
  canvas_list.each do |c|
    (that User).set_canvas_role(c, :member)
  end
end

Given /^I am the owner of a canvas$/ do
	set_that that(User)
  set_that Factory.create(:canvas, :creator => that(User))
end

Given /^(?:this|that) canvas has a page (?:titled|called) "([^"]*)"$/ do |pagetitle|
	page_prototype = Factory.build(:page, :title => pagetitle).attributes.except(
		"created_at", "updated_at", "page_id", "canvas_id", "id")
  page = (that Canvas).pages.create(page_prototype)
	set_that page
end

Given /^I am creating a canvas$/ do
  visit path_to("the New Canvas page")
	canvas = Factory.build(:canvas)
	fill_in("Name", :with => canvas.name)
	fill_in("Mission", :with => canvas.mission)
	fill_in("Image", :with => canvas.image)
end

Given /^that canvas is closed$/ do
  (that Canvas).open = false
end


When /^I specify that canvas should be "([^"]*)"$/ do |state|
	if state == "open"
		page.check("Open?")
	else
		page.uncheck("Open?")
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

Then /^that canvas should require membership to edit$/ do
	(that Canvas).open?.should be_false
end


