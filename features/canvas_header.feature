Feature: canvas homepage
  As a loorp community member
  I want a link to the community home from each community page
  so I can quickly get back to the community home

Scenario: Canvas name listed on canvas homepage
  Given there is a canvas 
  And I am on that canvas' homepage
  Then I should see that canvas' name within the canvas header
  
Scenario: Canvas name listed on canvas' pages
  Given there is a canvas 
  And that canvas has a page called "test page"
  And I am on that page
  Then I should see that canvas' name within the canvas header

