Then /^I should see links to those canvae$/ do
  (that User).canvas_roles.each do |cur|
    page.should have_selector("#canvas_#{cur.canvas.id}-menu")
  end
end