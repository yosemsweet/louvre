Then /^the page title should be "([^"]*)"$/ do |title|
  within("title") do 
    page.should have_content(title)
  end
end

Given /^I am "([^"]*)"$/ do |name|
 current_user = Factory.create(:user, :name => name)
end
