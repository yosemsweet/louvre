Given /^that canvas has a question widget$/ do
  Factory.create(:link_widget, :canvas => Canvas.last)
end