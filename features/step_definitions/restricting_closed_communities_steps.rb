Given /^that canvas is closed$/ do
  Canvas.any_instance.stubs(:closed?).returns(true)
end