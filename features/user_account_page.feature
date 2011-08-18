Feature: user hud
  As a member of loorp
  I want to edit my account 
  So that my info is current

@omniauth_test
@javascript
Scenario: Accessing my account page
  Given I am authenticated 
  And I am on the homepage
  When I follow "Account" 
  Then I should be on my account page
 
@omniauth_test
@javascript
Scenario: Adding an email address
  Given I am authenticated 
  And I am on my account page
  And I fill in "Address" with "gill@hotmail.com"
  And I press "Create Email"
  And I should see "gill@hotmail.com" in the list  