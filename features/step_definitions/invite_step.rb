Then /^I can invite other to join my canvas through email$/ do
  page.should have_selector('#invite_user') do |s|
    s.should have_link('invite')
  end
end
