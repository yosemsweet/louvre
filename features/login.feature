Feature: Require Login with Facebook
  In order to associate actions with people
  People should be able to
  Get authenticated with Loorp

@omniauth_test
Scenario: Sign up from canvas should redirect to canvas homepage
  Given I am on that canvas' homepage
  And I am not authenticated
  When I log in with "Facebook"
  Then I should be on that canvas' homepage
 
@omniauth_test
Scenario: Facebook Login
  Given I am not authenticated
  And I am on the homepage
  When I log in with "Facebook"
  Then I should not see "Log in with Facebook"

@omniauth_test
Scenario: Logout
    Given I am authenticated
    And I am on the homepage
    When I follow "Log out"
    Then I should see "Log in with Facebook"

@omniauth_test
Scenario Outline: Logging in places you on the page you logged in from.
   Given I am not authenticated
   And I am on <Page>
   When I log in with "Facebook"
   Then I should be on <Page>

 Examples:
 | Page                                        |
   | "the homepage"                    |
   | that canvas' homepage        |
   | that page                                |

