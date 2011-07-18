Feature: Require Login with Facebook
  In order to associate actions with people
  People should be able to
  Get authenticated with A Saucy Book
 
@omniauth_test
Scenario: Facebook Login
  Given I am not authenticated
  And I am on the homepage
  When I sign in with "Facebook"
  And I am signed in with "Facebook"
  Then I am logged in
