Feature: add image to input stream
As Gill Fert
I want to add an image item to the canvas' input stream
so that I can share interesting/valuable ideas with members of the community

@omniauth_test
@javascript
Scenario: Follow Add Image to show New Widget dialog
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
When I follow "Add Image"
Then I should see the new widget form
