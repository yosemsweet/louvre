Feature: canvas homepage
  As an audience member
  I want to visit the canvas homepage
  so that I participant in the community 
  
Scenario: Canvas Homepage Sections
Given there is a canvas 
And I am on that canvas' homepage
Then I should see "Edit"
And I should see "Input Stream"
And I should see "Pages"

@omniauth_test
Scenario: Canvas Bookmarklet Widget
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
Then I can install the canvas bookmarklet

@wip
@omniauth_test
@javascript
Scenario: Follow a canvas
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
Then I should see a follow button
When I press "Follow"
Then I should not see a follow button
And I should see "Following"