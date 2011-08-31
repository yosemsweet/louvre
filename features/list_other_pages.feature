Feature: list other pages on a canvas when on pages
As a page editor
I want to see what other pages are in the canvas
So I can link to them appropriately instead of adding their content to the page I'm currently editing.

@omniauth_test
Scenario: Seeing a list of canvas pages on the page edit page
Given I am authenticated
And there is a canvas
And that canvas has a page called "Page1"
And that canvas has a page called "Page2"
And I am on the edit page for "Page1"
Then I should see "Page2"

@omniauth_test
Scenario: Seeing a list of canvas pages on the page show page
Given I am authenticated
And there is a canvas
And that canvas has a page called "Page1"
And that canvas has a page called "Page2"
And I am on the show page for "Page1"
Then I should see "Page2"