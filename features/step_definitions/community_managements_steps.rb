Given /^"?(I|[^"]*)"? (?:am|is) (?:a|an) (user|admin)$/ do |user, role|
	if user == "I"
		member = current_user
	else
		member = User.find_by_name(user) || Factory.create(:user, :name => user)
	end
	if role == "admin"
		member.admin = true
	end
end

Given /^the following users exist:$/ do |users|
  users.hashes.each do |hash|
		Factory.create(:user, hash)
	end
end


Given /^"?(I|[^"]*)"? (?:am|is) (?:a|an|) (.*) (?:of|to|for) that canvas$/ do |user, role|
	if user == "I"
		member = current_user
	else
		member = User.where(:name => user).first
	end
	if role == "applicant"
		(that Canvas).canvas_applicants.create(:user_id => member.id)
	else
		member.set_canvas_role((that Canvas), role.to_sym)
	end
end

Given /^I have banned "([^"]*)"$/ do |user|
	member = User.find_by_name(user) || Factory.create(:user, :name => user)
	member.set_canvas_role(Canvas.last, :banned)
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

Then /I will see an admin indicator for each admin$/ do
	admins = User.where(:admin => true)
	admins.each do |a|
		page.should have_selector(".member-item.admin[data-user_id='#{a.id}']")
	end
end

Then /^"?(I|[^"]*)"? should ?(|not) be ?(?:a|an|)? (.+) (?:of|by|for) that canvas$/ do |name, type, role|
	if name == "I"
		user = current_user
	else
		user = User.find_by_name(name)
	end
	
	if type == "not"
		if role == "applicant"
			(that Canvas).canvas_applicants.should_not include(user)
		else
			user.canvas_role(that Canvas).should_not == role.to_sym
		end
	else
		if role == "applicant"
			(that Canvas).canvas_applicants.should include(user)
		else
			user.canvas_role(that Canvas).should == role.to_sym
		end
	end
end

Then /^"([^"]*)" should ?(|not) be an admin$/ do |name, type|
  user = User.find_by_name(name)

	if type == "not"
		user.should_not be_admin
	else
		user.should be_admin
	end
end
