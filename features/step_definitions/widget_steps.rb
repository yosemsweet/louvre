Given /^there is a widget$/ do
	(that Canvas).widgets.create(Factory.create(:widget))	
end

Given /^there is an input stream widget$/ do
	(that Canvas).widgets.create(Factory.create(:widget, :page => nil))	
end

Given /^that widget has a tag "([^"]*)"$/ do |tag|
  testtag = Factory.create(:tag, :name => tag)
  testtag2 = Factory.create(:tag, :name => "tag2")
  (that Widget).tags << testtag
  (that Widget).tags << testtag2
end

# Given /^I fill "([^"]*)" and select the first tag$/ do |tag_name|
#   within(".widget[data-widget_id='1']") do
#     find(".textboxlist").click()
#     fill_in('fillin', :with=>tag_name)
#     within(".textboxlist-autocomplete-results") do
#       find(".textboxlist-autocomplete-highlight").click()
#     end
#     button = find("input[type='submit']")
#     button.click
#   end
#   
#   When "I wait until all Ajax requests are complete"
#   puts Widget.last.to_yaml
#   # find("#widget_submit").click()
# end


Given /^I update the widget's text with "([^"]*)"$/ do |text|
  within(".widget[data-widget_id='#{Widget.last.id}']") do
    find(".edit").click()
    fill_in('widget_text', :with=>text)
    click_button("Save")
  end
end