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
  canvas = Factory.build(:canvas)
  user = Factory.build(:user)
  user.set_canvas_role(canvas, :member)
  page.execute_script("function(){_my_var=document.createElement('SCRIPT');_my_var.type='text/javascript';_my_var.text='canvas_id=#{canvas.id};user_id=#{user.id}';host_uri='#{host_uri}';_my_script=document.createElement('SCRIPT');_my_script.type='text/javascript';_my_script.src='#{host_uri}/javascripts/bookmarklet_dialog.js';element=document.getElementsByTagName('body')[0];element.appendChild(_my_var);element.appendChild(_my_script);}")
  #page.execute_script(bookmarklet(canvas, user))
	#wait = Selenium::WebDriver::Wait.new(:timeout => 600)
	#wait.until { page.has_selector?("#loorp_bookmarklet") }
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