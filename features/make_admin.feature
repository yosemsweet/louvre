Feature: make member administrator
  As Loorp Product Owner
  I want to to make certain Loorp team members admins
  So they can support our users
  
Background:
  Given I am authenticated
  And I am an admin
  And the following users exist:
  |name           | admin   |
  |Gill Fert      | false   |
  |Lex Luthor     | true    |
  |Darth Sidious  | true    |
  And I am on the users page


@omniauth_test
Scenario: See global list of users
  Then I should see all users in the user list

@omniauth_test
Scenario: See which users are admins and which aren't
  Then I will see an admin indicator for each admin
  
@omniauth_test
@javascript
Scenario: Make a user an admin
When I follow the admin link for "Gill Fert"
And I wait until all Ajax requests are complete
Then "Gill Fert" should be an admin

@omniauth_test
@javascript
Scenario: Make an admin a user
When I follow the user link for "Lex Luthor"
And I wait until all Ajax requests are complete
Then "Lex Luthor" should not be an admin
  