Given /^there is a link with "([^"]*)", "([^"]*)", and "([^"]*)"$/ do |title, link, text|
	widget = Factory.create(:link_widget, :canvas => Canvas.last, :content_type => "link_content", :title => title, :link => link, :text => text)
end

When /^(?:".+"|I) visit a page with the link added$/ do
	page = Factory.create(:page, :canvas => Canvas.last)
	cloned_widget = Widget.last.clone
	cloned_widget.page_id = page.id
	cloned_widget.save
	cloned_widget.insert_position(1)
	visit canvas_page_path(page.canvas, page)
end


