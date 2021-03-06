Given /^that (.+) has a (.+) widget$/ do |model, type|
	model = "canvae" if model == "canvas"
	klass = model.singularize.camelize.constantize
	widget_type = (type + "_widget").underscore.to_sym
	widget_prototype = Factory.create(widget_type).attributes.except(
		"created_at", "updated_at", "page_id", "canvas_id", "id")

  set_that (that klass).widgets.create(widget_prototype)
end

When /^(?:I )wait until all Ajax requests are complete$/ do
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end

When /^I click "([^"]*)" for "([^"]*)"$/ do |link, user|
  page.find(:xpath, "//*[contains(child::text(), user)]") do |scope|
		page.should have_link(link)
		page.click_link(link)
	end
end

When /^I follow that canvas' name$/ do
  page.should have_link(that(Canvas).name)
	page.click_link(that(Canvas).name)
end

When /^(?:|I )follow (.+) link$/ do |link|
  page.should have_selector(selector_for(link))
	page.find(selector_for(link)).click
end

When /^I mouse over "([^"]*)"$/ do |selector|
	page.find("#{selector_for(selector)}").trigger('mouseover')
end

When /^(?:|I )reload the page$/ do
  visit(current_path)
end

When /^(?:|I )reload that (.+)$/ do |model|
	model = "canvae" if model == "canvas"
	that(model.classify.constantize).reload
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

Then /^(?:|I )should see that (canvas|page|user|widget)'s? (\S+)$/ do |model, attribute|
	model = "canvae" if model == "canvas"
	klass = model.singularize.camelize.constantize
	Then %(I should see "#{that(klass).send(attribute)}")
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

Then /^I should see (.+) link$/ do |link|
  page.should have_selector(selector_for(link))
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

Then /^inspect that (.+)$/ do |model|
	model = "canvae" if model == "canvas"
	puts (that model.classify.constantize).to_yaml
end

Then /^"([^"]*)" should ?(|not) be visible$/ do |selector, type|
  selector = selector_for(selector)
  if type == "not"
    page.find(selector).should_not be_visible 
  else
    page.should have_selector(selector)
    page.find(selector).should be_visible
  end
end

Then /^"([^"]*)" should ?(|not) be there$/ do |selector, type|
  selector = selector_for(selector)
  if type == "not"
    page.should_not have_selector(selector)
  else
  	page.should have_selector(selector)
  end
end

Then /^the "([^"]*)" should contain "([^"]*)"$/ do |scope, content|
  page.find(scope).should have_content(content)
end

Then /^I should be redirected to (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^pending (.+)$/ do |message|
	puts message
end
