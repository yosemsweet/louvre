Feature: Create a page
  As Gill
  I want to create a new page within my canvas
  So that I can help Women of a Certain Age be Fashionable in greater details

Background:
Given I am "Gill"
And I am authenticated
And there is a canvas
And I am a member of that canvas

@omniauth_test
Scenario: Start Create Page - authenticated
And I am on that canvas' homepage
When I follow "Create Page"
Then I should be on "New Page page"

@omniauth_test
Scenario: Create Page - authenticated
And I am on the "New Page page"
When I fill in the following:
|Title     |Hats no one should wear| 
And I press "Save"
Then I should be on "Hats no one should wear edit page"
And I should see "Page created!"
And I should be the creator of the "Hats no one should wear" page