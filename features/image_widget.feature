Feature: image widgets
As Gill Fert
I want to see image on the canvas
so that I can share interesting/informative imagery with the community

@omniauth_test
@javascript
Scenario: Follow Add Image to show New Widget dialog
Given there is a canvas
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
When I follow "Share a photo"
Then "the new image widget form" should be visible

@javascript
Scenario: Image markup should be semantic
  Given there is a canvas
  And that canvas has an image widget with caption "I am a caption"
  And I am on that canvas' homepage
  And I wait until all Ajax requests are complete
  Then the page should include html "<figure><img/><figcaption>I am a caption</figcaption></figure>"
