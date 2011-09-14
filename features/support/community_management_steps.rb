Given /^I am a member of that canvas$/ do
  current_user.set_canvas_role(Canvas.last, :member)
end