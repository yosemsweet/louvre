Before('@background_user') do
  Factory.create(:user)
end

Before('@background_canvas') do
  Factory.create(:canvas)
end
