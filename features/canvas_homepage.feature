Feature: canvas homepage
  As an audience member
  I want to visit the canvas homepage
  so that I participant in the community 
  
Scenario: Canvas Homepage Sections
Given there is a canvas 
And I am on that canvas' homepage
Then I should see "Edit"
And I should see "Feed"
And I should see "Pages"

@omniauth_test
<<<<<<< HEAD
=======
@wip
>>>>>>> Trying to get bookmarklet helper working
@javascript
Scenario: Canvas Bookmarklet Widget
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
Then I can install the canvas bookmarklet