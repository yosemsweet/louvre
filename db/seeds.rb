User.create(
  :name => "Bob Dole",
  :provider => "facebook",
  :uid => 21009266,
  :image => "https://s3.amazonaws.com/randomfile/1.png",
  :email => "bob.dole@gmail.com"
)

1.upto(10) do |i|
  Canvas.create(
    :name => "Canvas number #{i}",
    :mission => "The mission that is the mission for canvas #{i}",
    :image => "https://s3.amazonaws.com/randomfile/#{i%5 + 1}.png"
  )
end