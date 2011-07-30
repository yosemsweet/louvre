Feature: add image to input stream
As Gill Fert
I want to add an image item to the canvas' input stream
so that I can share interesting/valuable ideas with members of the community

@omniauth_test
Scenario: Use form to add image url to input stream
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
When I follow "Add Image"
And I fill in "widget_content" with "image.jpg"
And I fill in "widget_alt_text" with "image alt text"
And I press "Save"
Then the image is added to the canvas' input stream