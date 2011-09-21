When /^(?:I )wait until all Ajax requests are complete$/ do
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end

Given /^there is a canvas$/ do
  Factory.create(:canvas)
end

Given /^I am "([^"]*)"$/ do |name|
 set_current_user( Factory.create(:user, :name => name) )
end

Given /^I am logged in$/ do
  @user = Factory.create(:user)
  set_current_user(@user)
end

Given /^this canvas has a page titled "([^"]*)"$/ do |pagetitle|
  page = Factory.create(:page, :title => pagetitle, :canvas => Canvas.last)
end

When /^I click "([^"]*)" for "([^"]*)"$/ do |link, user|
  page.find(:xpath, "//*[contains(child::text(), user)]") do |scope|
		page.should have_link(link)
		When I click link
	end
end

When /^I mouse over "([^"]*)"$/ do |selector|
	page.find("#{selector_for(selector)}").trigger('mouseover')
end

When /^(?:|I )reload the page$/ do
  visit(current_path)
end

When /^I wait (\d+) second[s?]$/ do |n|
	sleep n.to_i
end

Then /^the page title should be "([^"]*)"$/ do |title|
  within("title") do 
    page.should have_content(title)
  end
end

Then /^I see (?:the|a[n?]) "([^"]*)" dialog$/ do |dialog|
	page.should have_content(dialog)
end

Then /^(?:|I )should see the "([^"]*)" button$/ do |text|
  button_is_visible = page.has_button?(text) && page.find_button(text).visible?
  button_is_visible.should == true
end

Then /^"([^"]*)" should be visible$/ do |selector|
	page.should have_selector(selector_for(selector))
	page.find(selector_for(selector)).should be_visible
end

Then /^(?:|I )should not see the "([^"]*)" button$/ do |text|
  button_is_visible = page.has_button?(text) && page.find_button(text).visible?  
  button_is_visible.should == false
end

Then /^I see the page$/ do
	puts page.html
end

Then /^(?:|the page should include|I should see) html "([^"]*)"$/ do |html|
	should have_html(html)
end

Then /^I should see the "([^"]*)" image$/ do |image|
  page.should have_selector("##{image}")
	page.find("##{image}").should be_visible
end

Then /^I should see "([^"]*)" in (.+)$/ do |content,scope|
	with_scope(scope) do
		page.should have_content(content)
	end
end

Then /^I should see all (.+) in (.+)$/ do |model,scope|
	with_scope(scope) do
		model.classify.constantize.all.each do |m|
			page.should have_selector(".item[data-#{model.classify.underscore}_id='#{m.id}']")
		end
	end
end

Then /^I should not see the "([^"]*)" image$/ do |image|
	page.should have_selector("##{image}")
	page.find("##{image}").should_not be_visible
end

Then /take a snapshot(| and show me the page)/ do |show_me|
  page.driver.render Rails.root.join("tmp/capybara/#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.png")
  Then %{show me the page} if show_me.present?
end

Then /^vomit the page$/ do
  puts page.html
end

Then /^test$/ do
  puts page.html
  with_scope "the feed" do
    # page.find("")
    # puts page.find(".edit").text
  end
end

Then /^the "([^"]*)" should contain "([^"]*)"$/ do |scope, content|
  page.find(scope).should have_content(content)
end
