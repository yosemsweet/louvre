Given /^that canvas has a page called "([^"]*)"$/ do |title|
  page = Factory.create(:page, :title => title, :canvas => Canvas.last)
end