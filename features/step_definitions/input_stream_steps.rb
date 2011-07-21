Given /^I am browsing "([^"]*)"$/ do |page|
  set_current_page(page)
end

Given /^I have a canvas bookmarklet$/ do
  Given "there is a canvas"
end

When /^I use the bookmarklet$/ do
  post "/canvae/#{Canvas.last.id}/things", current_page
end

Then /^the webpage link is added to the canvas' input stream$/ do
  pending # express the regexp above with the code you wish you had
end
