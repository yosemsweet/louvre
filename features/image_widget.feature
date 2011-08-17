Feature: image widgets
As Gill Fert
I want to see image on the canvas
so that I can share interesting/informative imagery with the community

@omniauth_test
@javascript
Scenario: Follow Add Image to show New Widget dialog
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
When I follow "Add Image"
Then I should see the new widget form
