Then /^I should see a link to comment on that widget$/ do
	puts page.html
  page.should have_selector('.widget') do |selector|
		selector.should have_selector('a',:content => "discuss")
	end
end
