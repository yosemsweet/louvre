Then /^I should see the image "(.+)"$/ do |image|
    page.should have_xpath("//img[\"imageurl\"]")
end

Then /^the webpage link is added to the canvas' input stream$/ do
	Canvas.last.widgets.find_by_link(current_page).should be_present
end

Then /^the image is added to the canvas' input stream$/ do
  Canvas.last.widgets.find_by_image("image.jpg")
end

Given /^that canvas has an image widget with caption "([^"]*)"$/ do |caption|
  widget = Factory.create(:image_widget, :alt_text => caption, :canvas => Canvas.last)
end