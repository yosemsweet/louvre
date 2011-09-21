RSpec::Matchers.define :have_widget_elements_for do |widget|
  match do |actual|
		@errors = {}

		expected_elements = {
			:widget => ".widget",
			:content_type => ".#{widget.content_type}",
			:body => ".body",
			:title => ".title",
			:toolbox => ".toolbox",
			:content => ".content"
		}

		error_prefix = "Can't find selector "
		expected_elements.each do |key, selector|
			@errors[key] = error_prefix + selector unless have_selector(selector).matches?(actual)
		end
			
		@errors.empty?
  end

	
	failure_message_for_should do |actual|
    message = "expected #{actual} to have widget elements"
		message += "\n#{@errors.to_yaml}" unless @errors.empty?
		message
  end

  failure_message_for_should_not do |actual|
    message = "expected #{actual} to not have widget elements"
		message += "\n#{@errors.to_yaml}" unless @errors.empty?
		message
  end

  description do
    message = "has widget elements for #{widget}"
  end

end