Given /^I am browsing "([^"]*)"$/ do |page|
  set_current_page(page)
end

Then /^I should see the image "(.+)"$/ do |image|
    page.should have_xpath("//img[\"imageurl\"]")
end

Given /^I have a canvas bookmarklet$/ do
  Given "there is a canvas"
end

When /^I use the bookmarklet$/ do
  result = post "/canvae/#{Canvas.last.id}/widgets.json", :widget => {:content => current_page, :creator_id => current_user.id, :content_type => 'text_content'}
  set_input_stream_call_status(result.status)
end

Then /^the webpage link is added to the canvas' input stream$/ do
  When "I am on that canvas' homepage"
  Then "I should see \"#{current_page}\"" 
end

Then /^the image link is added to the canvas' input stream$/ do
  When "I am on that canvas' homepage"
  Then "I should see the image \"imageurl\"" 
end
