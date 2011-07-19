Feature: Create a canvas
  As Gill
  I want to create a new canvas
  So that I can help Women of a Certain Age be Fashionable
 
@omniauth_test
Scenario: Start Create Canvas Wizard
Given I am "Gill"
And I am authenticated
And I am on "the homepage"
When I follow "Create Canvas"
Then I should be on "the New Canvas page"

