Feature: tab interface for new widgets
As Gill Fert
I want the new widget forms to be tabbed
so that it feels good

@omniauth_test
@javascript
Scenario: tab interface for new widgets
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
When I follow "Add Text"
Then I should see the new text widget form
When I follow "Add Image"
Then I should see the new image widget form
And I should not see the new text widget form