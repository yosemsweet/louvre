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
			
		when /the new (.+) widget form/
      "#inline_form .widget.#{$1}_content"
      
  	when /the new widget form/
      "#inline_form .widget"
			
		when "that widget"
			".widget[data-widget_id='#{(that Widget).id}']"
			
		when /that (.+)'s (.+) link/
			klass = $1.classify.constantize
			object = that klass
			".#{klass.to_s.downcase}[data-#{klass.to_s.downcase}_id='#{object.id}'] .#{$2}"
		
		when "the communities menu"
		  "#menubar #canvae-menu"
		
		when "the canvas header"
			"#canvas_header"
			
		when "that canvas' homepage link"
			"a[href='#{path_to(%|that canvas' homepage|)}']"
		
		when "the user details"
			"#user-nav"
			
		when "orientation box"
			"#intro"
			
		when "canvas settings hint"
		  ".hint[data-target='#canvas-settings']"
		
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
