Feature: Editing a widget
  As Gill Fert
  I want to be able to edit a widget
  so that I can correct any mistakes

@omniauth_test
@javascript
Scenario: See edit link on mouseover on canvas
Given there is a canvas
And that canvas has a link widget
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
And I wait until all Ajax requests are complete
When I mouse over "that widget"
Then "that widget's edit link" should be visible

@omniauth_test
@javascript
Scenario: See edit link on mouseover on page
Given there is a canvas
And that canvas has a page titled "Page 1"
And that page has a link widget
And I am authenticated
And I am a member of that canvas
And I am on the edit page for "Page 1"
When I mouse over "that widget"
Then "that widget's edit link" should be visible

@omniauth_test
@javascript
Scenario: Updating the link widget text
Given there is a canvas
And that canvas has a link widget
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
And I update the widget's text with "hello"
And I wait until all Ajax requests are complete
Then I should see "hello"

@wip
@omniauth_test
@javascript
Scenario: Updating the link widget text on a page
Given there is a canvas
And that canvas has a page titled "Page 1"
And that page has a link widget
And I am authenticated
And I am a member of that canvas
And I am on the edit page for "Page 1"
And I update the widget's text with "hello"
And I wait until all Ajax requests are complete
Then I should see "hello"