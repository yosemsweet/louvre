Given /^I am browsing "([^"]*)"$/ do |page|
  set_current_page(page)
end

Given /^I have a canvas bookmarklet$/ do
  Given "there is a canvas"
end

Given /^I have selected some text on the screen$/ do
	set_selection("<h2>CNN</h2>")
end

When /^I use the bookmarklet$/ do
	page.execute_script(bookmarklet(Canvas.last, User.last))
	wait = Selenium::WebDriver::Wait.new(:timeout => 600)
	wait.until { page.has_selector?("#loorp_bookmarklet") }
end


When /^I submit a link to the canvas$/ do
	result = post "/widgets/", :canvas_id => Canvas.last.id, :widget => {:link => current_page, :title => "CNN", :creator_id => User.last.id, :content_type => 'link_content', :text => selection.html_safe}
  set_input_stream_call_status(result.status)
end

Then /^the text is added to the canvas' input stream as part of a link$/ do
	widget = Canvas.last.widgets.where(:content_type => "link_content", :link => current_page).last
	widget.should be_present
	widget.text.should == selection.html_safe
end