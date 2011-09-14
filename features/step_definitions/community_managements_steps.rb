Given /^that canvas is closed$/ do
  Canvas.any_instance.stubs(:closed?).returns(true)
end

Given /^"([^"]*)" is a user$/ do |user|
	Factory.create(:user, :name => user) unless User.exists?(:name => user)
end

Given /^I am a member of that canvas$/ do
	current_user.set_canvas_role(Canvas.last, :member)
end

Given /^I have banned "([^"]*)"$/ do |user|
  User.where(:name => user).first.set_canvas_role(Canvas.last, :banned)
end
