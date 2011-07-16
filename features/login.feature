Feature: Require Login with Facebook
  In order to associate actions with people
  People should be able to
  Get authenticated with A Saucy Book
 
Scenario: Facebook Connect Login
  Given I am not authenticated
  And I am on the homepage
  When I press "Connect with Facebook"
  And I am authenticated by facebook
  Then I am logged in
