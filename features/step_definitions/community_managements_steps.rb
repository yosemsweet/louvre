Given /^that canvas is closed$/ do
  Canvas.any_instance.stubs(:closed?).returns(true)
end

Given /^"([^"]*)" is a user$/ do |user|
	Factory.create(:user, :name => user) unless User.exists?(:name => user)
end

Given /^"?(I|[^"]*)"? (?:am|is) (?:a|an|) (.*) (?:of|to|for) that canvas$/ do |user, role|
	if user == "I"
		member = current_user
	else
		member = User.where(:name => user).first
	end
	if role == "applicant"
		Canvas.last.canvas_applicants.create(:user_id => member.id)
	else
		member.set_canvas_role(Canvas.last, role.to_sym)
	end
end

Given /^I have banned "([^"]*)"$/ do |user|
	User.where(:name => user).first.set_canvas_role(Canvas.last, :banned)
end

When /^I follow the (.*) link for "([^"]*)"$/ do |action, name|
	user = User.where(:name => name).first
	within(".member-item[data-user_id='#{user.id}']") do
		find(".#{action}").click()
	end
end

Then /^I should see (?:a|an) (.*) link for "([^"]*)"$/ do |action, name|
	user = User.where(:name => name).first
	
	page.should have_selector(".member-item[data-user_id='#{user.id}'] a.#{action}")
end

Then /^"([^"]*)" should ?(|not) be banned$/ do |name, type|
  user = User.where(:name => name).first

	if type == "not"
		user.canvas_role(Canvas.last).should_not == :banned
	else
		user.canvas_role(Canvas.last).should == :banned
	end
end
