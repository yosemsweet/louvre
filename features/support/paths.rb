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

		when /log in/
			login_path

		when /log out/
			logout_path
			
		when /the new canvas page/
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
		  canvas = that Canvas
		  canvas_path(canvas)
		
		when /that canvas' settings page/
			canvas = that Canvas
			edit_canvas_path(canvas)
		
		when /that canvas' ban management page/
			canvas = that Canvas
			banned_canvas_path(canvas)
			
		when /that canvas' member management page/
			canvas = that Canvas
			members_canvas_path(canvas)
			
		when /that canvas' applicant management page/
			canvas = that Canvas
			applicants_canvas_path(canvas)

		when /that widget's page/
		  widget = that Widget
		  canvas_widget_path(widget.canvas, widget)
		
		when /that page/
			page = that Page
			canvas_page_path(page.canvas, page)

		when /my account page/
		  edit_user_path
		  
		when /cnn/ 
		  "http://localhost:3000"
		  
  	when /the edit page for "([^"]*)"/
  	  page = Page.where(:title => "#{$1}").first
  	  edit_canvas_page_path(page.canvas, page)
  	
  	when /the show page for "([^"]*)"/
  	  page = Page.where(:title => "#{$1}").first
  	  canvas_page_path(page.canvas, page)  

		when /the users page/
			users_path

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
