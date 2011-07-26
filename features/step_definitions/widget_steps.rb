Given /^there is a widget$/ do
	Canvas.last.widgets.create(Factory.create(:widget))	
end
