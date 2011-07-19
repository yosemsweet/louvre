Feature: Create a canvas
  As Gill
  I want to create a new canvas
  So that I can help Women of a Certain Age be Fashionable
 
@omniauth_test
Scenario: Start Create Canvas Wizard - authenticated
Given I am "Gill"
And I am authenticated
And I am on "the homepage"
When I follow "Create Canvas"
Then I should be on "the New Canvas page"

Scenario: Can't create canvas if not authenticated
Given I am not authenticated
And I am on "the homepage"
Then I should not see "Create Canvas"

