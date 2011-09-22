if Rails.env.development?

  Widget.delete_all
  Page.delete_all
  Canvas.delete_all
  User.delete_all
  Email.delete_all

  user = User.create(
    :name => "Bob Dole",
    :provider => "facebook",
    :uid => 21009266,
    :image => "https://s3.amazonaws.com/randomfile/1.png",
    :last_action => Time.now
  )

  user2 = User.create(
    :name => "Socra Tease",
    :provider => "facebook",
    :uid => 21009243,
    :image => "https://s3.amazonaws.com/randomfile/1.png",
    :last_action => Time.now
  )

  user3 = User.create(
    :name => "Tom Cruise",
    :provider => "facebook",
    :uid => 21009213,
    :image => "https://s3.amazonaws.com/randomfile/1.png",
    :last_action => Time.now
  )

  user4 = User.create(
    :name => "Justin Bieber",
    :provider => "facebook",
    :uid => 21009213,
    :image => "https://s3.amazonaws.com/randomfile/1.png",
    :last_action => Time.now
  )

  email = Email.create(
	:user => user,
	:address => "bob.dole@loorp.com"
  )

  email2 = Email.create(
	:user => user2,
	:address => "socra.tease@loorp.com"
  )

  email3 = Email.create(
	:user => user3,
	:address => "tom.cruise@loorp.com"
  )

  email4 = Email.create(
	:user => user4,
	:address => "justin.bieber@loorp.com"
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

  user2.set_canvas_role(open_canvas, :banned)
  user2.set_canvas_role(closed_canvas, :member)
  user3.set_canvas_role(open_canvas, :member)
  user3.set_canvas_role(closed_canvas, :banned)
  
  CanvasApplicant.create(:canvas_id => open_canvas.id, :user_id => user4.id, :note => "I like!")
  CanvasApplicant.create(:canvas_id => closed_canvas.id, :user_id => user4.id, :note => "I can has membership?")
  
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