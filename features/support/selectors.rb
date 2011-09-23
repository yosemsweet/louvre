module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"
    
    when "the feed"
      "#feed"

		when /the (.+) list/
			"##{$1}-list"
			
		when "that widget"
			debugger
			".widget[data-widget_id='#{(that Widget).id}']"
			
		when /that (.+)'s (.+) link/
			klass = $1.classify.constantize
			object = that klass
			".#{klass.to_s.downcase}[data-#{klass.to_s.downcase}_id='#{object.id}'] .#{$2}"
		
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps as was previously the default for the
    # web steps:
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)
