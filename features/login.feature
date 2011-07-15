feature: Require Login with Facebook
  In order to associate actions with people
  As a product manager
  I want people to register for A Saucy Book
 
@wip 
Scenario: Facebook Connect Login
  Given I am not logged in
  When I click "Connect with Facebook"
  Then I am logged in