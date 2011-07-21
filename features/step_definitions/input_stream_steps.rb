Given /^I am browsing "([^"]*)"$/ do |page|
  set_current_page(page)
end

Given /^I have a canvas bookmarklet$/ do
  Given "there is a canvas"
end

When /^I use the bookmarklet$/ do
  result = post "/canvae/#{Canvas.last.id}/things.json", :thing => {:content => current_page, :creator_id => current_user.id}
  set_input_stream_call_status(result.status)
end

Then /^the webpage link is added to the canvas' input stream$/ do
  When "I am on that canvas' homepage"
  Then "I should see \"#{current_page}\"" 
end


Then /^I see an error$/ do
  (400...500).should === input_stream_call_status
end

