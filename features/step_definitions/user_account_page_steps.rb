Given /^I should see "([^"]*)" in the list$/ do |address|
  within "#user_emails" do
    page.should have_content address
  end
end