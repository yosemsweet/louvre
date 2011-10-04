module UsersHelper
  
  def first_canvas(canvas, user)
    canvas.creator == user && user.canvae.count == 1
  end
  def hint_for(canvas, user, target)
    case target
    # only show canvas hint if first canvas and has not been updated
    when "canvas"
      if first_canvas(canvas, user) && canvas.created_at == canvas.updated_at 
        result = render 'shared/hint', :title => 'What would you like to call your community?', :content => "Don't stress, you can always change it later.", :klass => "left-up", :target => "edit-title"
      end
    # only show add widget help if user has not added widgets before
    when "widget"
      if first_canvas(canvas, user) && canvas.widgets.count == 1 && canvas.widgets.first.updated_at - canvas.created_at < 1.second 
        result = render 'shared/hint', :title => "We've added a snippet to your feed already", :content => "Click here to edit.", :klass => "right-down", :target => "edit-widget"
      end
    # only show page hint if no page has been created before
    when "page"
      if first_canvas(canvas, user) && canvas.pages.count == 0 && canvas.widgets.count <= 1
        result = render 'shared/hint', :title => 'Need some organization?', :content => "add snippets to pages to organize them", :klass => "left-down", :target => "add-page"
      end
    end
    return result || ""
  end  
end
