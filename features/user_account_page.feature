Feature: user account
  As a member of loorp
  I want to edit my account 
  So that my info is current
 
@omniauth_test
@javascript
Scenario: Adding an email address
  Given I am authenticated 
  And I am on my account page
  And I fill in "Email Address" with "gill@hotmail.com"
  And I press "Register"
  And I should see "gill@hotmail.com" in the email list  