module UsersHelper
  
  def first_canvas(canvas, user)
    canvas.creator == user && user.canvae.count == 1
  end

  def hint_for(canvas, user, target)
	
    case target
	
    # only show canvas hint if first canvas and has not been updated
    when "canvas"
      if first_canvas(canvas, user) && canvas.created_at == canvas.updated_at 
        result = render 'shared/hint', :heading => 'Want to change your community name?', :content => "Check out the community settings by clicking on this icon.", :klass => "left up", :target => "#canvas-settings"
      end

    # only show add widget help if user has not added widgets before
    when "widget"
      if first_canvas(canvas, user) && canvas.widgets.count == 1 && canvas.widgets.first.updated_at - canvas.created_at < 1.second 
        result = render 'shared/hint', :heading => "We've added a snippet to your feed already", :content => "Click here to edit.", :klass => "right up", :target => ".snippet[data-widget_id='#{canvas.widgets.first.id}'] .tool.edit"
      end

    # only show page hint if no page has been created before
    when "page"
      if first_canvas(canvas, user) && canvas.pages.count == 0 && canvas.widgets.count <= 1
        result = render 'shared/hint', :heading => 'Need some organization?', :content => "Create a page and add snippets to it", :klass => "left down", :target => ".add_page:first"
      end
    end

		#TODO remove the following line once we have the new hints system in place.
		# result = ""
    return result || ""
  end  
end
