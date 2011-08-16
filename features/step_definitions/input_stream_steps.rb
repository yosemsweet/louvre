

Then /^I should see the image "(.+)"$/ do |image|
    page.should have_xpath("//img[\"imageurl\"]")
end

Then /^the webpage link is added to the canvas' input stream$/ do
	Canvas.last.widgets.find_by_link(current_page).should be_present
end

Then /^the image is added to the canvas' input stream$/ do
  Canvas.last.widgets.find_by_image("image.jpg")
end

Then /^the text is added to the canvas' input stream as part of a link$/ do
	widget = Canvas.last.widgets.where(:content_type => "link_content", :link => current_page).last
	widget.should be_present
	widget.text.should == selection.html_safe
end