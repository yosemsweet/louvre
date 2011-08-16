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
	page.execute_script("$('body').empty()")
end


When /^I submit a link to the canvas$/ do
	result = post "/widgets/", :canvas_id => Canvas.last.id, :widget => {:link => current_page, :title => "CNN", :creator_id => current_user.id, :content_type => 'link_content', :text => selection.html_safe}
  set_input_stream_call_status(result.status)
end
