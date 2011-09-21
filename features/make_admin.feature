Feature: make member administrator
  As Loorp Product Owner
  I want to to make certain Loorp team members admins
  So they can support our users
  
@omniauth_test
Scenario: See global list of users
  Given I am authenticated
  And I am an admin
  And the following users exist:
  |name           |
  |Gill Fert      |
  |Lex Luthor     |
  |Darth Sidious  |
  When I go to the users page
  Then I should see all users in the user list
  