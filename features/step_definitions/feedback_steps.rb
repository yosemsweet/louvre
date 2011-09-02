Then /^my feedback should be recorded$/ do
  Feedback.last.interested_in.should_not be_nil 
end