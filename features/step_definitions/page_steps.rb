Given /^I am editing that page$/ do
	page = that Page
	visit edit_canvas_page_path(page.canvas, page)
end

When /^(?:".+"|I) visit a page with the link added$/ do
	page = Factory.create(:page, :canvas => Canvas.last)
	cloned_widget = Widget.last.clone
	cloned_widget.page_id = page.id
	cloned_widget.save
	cloned_widget.insert_position(1)
	visit canvas_page_path(page.canvas, page)
end


Then /^I should be the creator of the "([^"]*)" page$/ do |pagetitle|
  Page.find_by_title(pagetitle).creator.should == current_user
end
