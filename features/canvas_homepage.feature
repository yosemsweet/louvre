Feature: canvas homepage
  As an audience member
  I want to visit the canvas homepage
  so that I participant in the community 
  
Scenario: Canvas Homepage Sections
Given there is a canvas 
And I am on that canvas' homepage
And I should see the feed

@omniauth_test
@javascript
Scenario: Canvas Bookmarklet Widget
  Given there is a canvas
  And I am authenticated
  And I am a member of that canvas
  And I am on that canvas' homepage
  Then I can install the canvas bookmarklet

