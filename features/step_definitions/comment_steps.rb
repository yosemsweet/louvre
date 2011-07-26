Then /^I should see a link to comment on that widget$/ do
  page.should have_selector('.widget') do |selector|
		selector.should have_selector('a',:content => "discuss")
	end
end

Then /^I should see that comment$/ do
	comment = Comment.last
  page.should have_selector("#comment_#{comment.id}")
end
