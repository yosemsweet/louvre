Then /^I should see the new text widget form$/ do
  page.find("ul#inline_form .text_content.widget").should be_visible
end

Then /^I should see the new image widget form$/ do
  page.find("ul#inline_form .image_content.widget").should be_visible
end

Then /^I should not see the new text widget form$/ do
  page.find("ul#inline_form .text_content.widget").should_not be_visible
end