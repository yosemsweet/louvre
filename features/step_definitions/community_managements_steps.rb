Given /^that canvas is closed$/ do
  Canvas.any_instance.stubs(:closed?).returns(true)
end

Given /^"([^"]*)" is a user$/ do |user|
	Factory.create(:user, :name => user) unless User.exists?(:name => user)
end

Given /^"?(I|[^"]*)"? (?:am|is) a member of that canvas$/ do |user|
	if user == "I"
		member = current_user
	else
		member = User.where(:name => user).first
	end
	member.set_canvas_role(Canvas.last, :member)
end

Given /^I have banned "([^"]*)"$/ do |user|
	User.where(:name => user).first.set_canvas_role(Canvas.last, :banned)
end

When /^I follow the (.*) link for "([^"]*)"$/ do |action, name|
	user = User.where(:name => name).first
	within(".user[data-user_id='#{user.id}']") do
		click_link(action)
	end
end

Then /^I should see a ban link for "([^"]*)"$/ do |name|
	user = User.where(:name => name).first
	
	page.should have_selector("li.user[data-user_id='#{user.id}'] a.ban")
end

Then /^"([^"]*)" should be banned$/ do |name|
  user = User.where(:name => name).first
	user.canvas_role(Canvas.last).should == :banned
end
