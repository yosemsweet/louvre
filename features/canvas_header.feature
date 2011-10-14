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

@omniauth_test
Scenario: Canvas name listed on canvas' pages' edit mode
  Given there is a canvas 
  And that canvas has a page called "test page"
  And I am authenticated
  And I am a member of that canvas
  And I am editing that page
  Then I should see that canvas' name within the canvas header

@omniauth_test
Scenario: Canvas name listed on canvas' setting page
  Given there is a canvas 
  And I am an owner of that canvas
  And I am on that canvas' settings page
  Then I should see that canvas' name within the canvas header
 
@omniauth_test
Scenario: Canvas name listed on canvas' member management page
  Given there is a canvas 
  And I am an owner of that canvas
  And I am on that canvas' member management page
  Then I should see that canvas' name within the canvas header

@omniauth_test
Scenario: Canvas name listed on canvas' widget details
  Given there is a canvas
  And that canvas has a widget
  And I am on that widget's page
  Then I should see that canvas' name within the canvas header
  
Scenario: Canvas name links to canvas home
  Given there is a canvas
  And that canvas has a page called "test page"
  And I am on that page
  When I follow that canvas' name within the canvas header
  Then I should be on that canvas' homepage
  
@wip
Scenario: Canvas name doesn't link to canvas home if on Canvas homepage
  Given there is a canvas
  And I am on that canvas' homepage
  Then there should not be a link with that canvas' name within the canvas header
