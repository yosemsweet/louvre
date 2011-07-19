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


@omniauth_test
Scenario: Create Canvas - authenticated
Given I am "Gill"
And I am authenticated
And I am on "the New Canvas page"
When I fill in the following:
|Name     |Fashion of a Certain Age| 
|Mission  |Better clothing for women of a certain age!|
|Image url|http://www.carniola.org/theglory/images/McHammer.gif|
And I press "Save"
Then I should be on "the Fashion of a Certain Age canvas homepage"
And I should see "Canvas created!"

