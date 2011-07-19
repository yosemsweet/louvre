Feature: canvas homepage
  As an audience member
  I want to visit the canvas homepage
  so that I participant in the community 
  
Scenario: Canvas Homepage Sections - 
Given there is a canvas 
And I am on that canvas' homepage
Then I should see "Edit"
And I should see "Input Stream"
And I should see "Pages"