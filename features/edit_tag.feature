Feature: editing widgets
As Gill Fert 
I want to be able to edit a page
So that I can refine it to make it better

@omniauth_test
@javascript
Scenario: Updating the link widget text
Given there is a canvas
And that canvas has an text widget
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
And I update the widget's text with "hello"
And I wait until all Ajax requests are complete
Then I should see "hello"
