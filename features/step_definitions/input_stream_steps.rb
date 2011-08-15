Given /^I am browsing "([^"]*)"$/ do |page|
  set_current_page(page)
end

Then /^I should see the image "(.+)"$/ do |image|
    page.should have_xpath("//img[\"imageurl\"]")
end

Given /^I have a canvas bookmarklet$/ do
  Given "there is a canvas"
end

Given /^I have selected some text on the screen$/ do
	set_selection("<h2>CNN</h2>")
end

When /^I use the bookmarklet$/ do
  result = post "/widgets/", :canvas_id => Canvas.last.id, :widget => {:text => current_page, :creator_id => current_user.id, :content_type => 'text_content'}
  set_input_stream_call_status(result.status)
end

Then /^the webpage link is added to the canvas' input stream$/ do
	Canvas.last.widgets.find_by_link(current_page).present?
end

Then /^the image is added to the canvas' input stream$/ do
  Canvas.last.widgets.find_by_image("image.jpg")
end

Then /^the text is added to the canvas' input stream as part of a link$/ do
	widget = Canvas.last.widgets.find(:conditions => {:content_type => "link_content", :link => current_page})
	widget.should be_present
	widget.text.should == selection
end