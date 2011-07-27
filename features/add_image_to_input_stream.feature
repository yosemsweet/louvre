Feature: add image to input stream
As Gill Fert
I want to add an image item to the canvas' input stream
so that I can share interesting/valuable ideas with members of the community

@omniauth_test
Scenario: Use form to add image url to input stream
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
When I follow "Add image to input stream"
And I fill in "image_field" with "http://url_of_image.com/image.jpg"
Then the image link is added to the canvas' input stream