module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the homepage/
      '/'
    when /Thanks for your interest/
      '/thankyou'

		when /log out/
			logout_path
			
		when /the New Canvas page/
			new_canvas_path
			
		when /New Page page/
			new_canvas_page_path(Canvas.last)
			
		when /Hats no one should wear page/
			page = Page.find_by_title('Hats no one should wear')
			canvas_page_path(page.canvas,page)
			
		when /Hats no one should wear edit page/
			page = Page.find_by_title('Hats no one should wear')
			edit_canvas_page_path(page.canvas,page)	
			
		when /Fashion of a Certain Age canvas homepage/
			canvas = Canvas.find_by_name('Fashion of a Certain Age')
			canvas_path(canvas)
			
		when /that canvas' homepage/
		  canvas = Canvas.last
		  canvas_path(canvas)

		when /that widget's page/
		  widget = Widget.last
		  canvas_widget_path(widget.canvas, widget)
		
		when /that page/
			page = Page.last
			canvas_page_path(page.canvas, page)
		  
		when /the user hud page/
		  puts("Path is #{hud_user_path(current_user)}")
		  hud_user_path(current_user)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
