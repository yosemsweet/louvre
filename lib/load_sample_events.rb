canvas = Canvas.last
user = User.last
page = canvas.pages.last
widget = canvas.widgets.last

Event.create! do |e|
  e.canvas = canvas
  e.user = user
  e.loggable = page
  e.description = "This is the description!"
end

Event.create! do |e|
  e.canvas = canvas
  e.user = user
  e.loggable = canvas
  e.description = "This is anopther thing that happened"
end

Event.create! do |e|
  e.canvas = canvas
  e.user = user
  e.loggable = widget
  e.description = "This is the third event that I am entering"
end

Event.create! do |e|
  e.canvas = canvas
  e.user = user
  e.loggable = widget
  e.description = "Events are good for the soul"
end
  