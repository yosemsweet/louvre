Feature: Navigate pages in a canvas
  As Gill
  I want to navigate pages within a canvas
  So that I can get to pages that are of interest to me

Background: 
Given there is a canvas 
And this canvas has a page titled "Hats no one should wear"

Scenario: See a list of pages on a canvas
When I am on that canvas' homepage
Then I should see "Hats no one should wear"

Scenario: Click on a page link to go to that page
When I am on that canvas' homepage
When I follow "Hats no one should wear"
Then I should be on "Hats no one should wear page"