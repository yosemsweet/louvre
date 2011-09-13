if Rails.env.development?

  Widget.delete_all
  Page.delete_all
  Canvas.delete_all
  User.delete_all

  user = User.create(
    :name => "Bob Dole",
    :provider => "facebook",
    :uid => 21009266,
    :image => "https://s3.amazonaws.com/randomfile/1.png"
  )

  open_canvas = Canvas.create(
    :name => "Open canvas",
    :mission => "The mission that is the mission for canvas 1",
    :image => "https://s3.amazonaws.com/randomfile/1.png",
    :open => true,
    :creator_id => user.id
  )

  closed_canvas = Canvas.create(
    :name => "Closed canvas",
    :mission => "The mission that is the mission for canvas 2",
    :image => "https://s3.amazonaws.com/randomfile/2.png",
    :open => false,
    :creator_id => user.id
  )

  page1 = Page.create(
    :title => "My page title",
    :canvas_id => open_canvas.id,
    :creator_id => user.id
  )

  page2 = Page.create(
    :title => "Other page title",
    :canvas_id => closed_canvas.id,
    :creator_id => user.id
  )

  widget1 = Widget.create(
    :text => "The text on this widget.",
    :canvas_id => open_canvas.id,
    :creator_id => user.id,
    :content_type => "text_content"
  )

  widget2 = Widget.create(
    :text => "A widget on a page.",
    :canvas_id => open_canvas.id,
    :creator_id => user.id,
    :content_type => "text_content",
    :page_id => page1.id
  )

  widget3 = Widget.create(
    :text => "Another widget.",
    :canvas_id => closed_canvas.id,
    :creator_id => user.id,
    :content_type => "text_content"
  )

  widget4 = Widget.create(
    :text => "A widget on a page.",
    :canvas_id => open_canvas.id,
    :creator_id => user.id,
    :content_type => "text_content",
    :page_id => page2.id
  )

else
  puts "Only seeds for development!! XD LOL HAHA"
end