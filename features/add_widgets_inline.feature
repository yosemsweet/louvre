Feature: tab interface for new widgets
As Gill Fert
I want the new widget forms to be tabbed
so that it is easy to add things

@omniauth_test
@javascript
Scenario: tab interface for new widgets
Given there is a canvas
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
When I follow "Add snippet"
Then "the new text widget form" should be visible
When I follow "Share a photo"
Then "the new image widget form" should be visible
And "the new text widget form" should not be visible
