Given /^there is a widget$/ do
	Canvas.last.widgets.create(Factory.create(:widget))	
end

Given /^there is an input stream widget$/ do
	Canvas.last.widgets.create(Factory.create(:widget, :page => nil))	
end