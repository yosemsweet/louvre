Given /^that canvas has a page called "([^"]*)"$/ do |title|
  page = Canvas.last.pages.create(:title => title, :creator => User.last)
	puts Canvas.last.id
end