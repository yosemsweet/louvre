Feature: add input via bookmarklet
As Gill Fert 
I want to add content to my canvas input stream via bookmarklets 
so that I can share interesting information with my friends

@background_user
@wip
Scenario: Use bookmarklet from a web page adds to input stream
Given I am browsing "cnn"
And I have a canvas bookmarklet
When I use the bookmarklet
Then the webpage link is added to the canvas' input stream

@background_user, @wip
Scenario: Select text on page
Given I am browsing "cnn"
And I have selected some text on the screen
And I have a canvas bookmarklet
When I use the bookmarklet
Then the text is added to the canvas' input stream as part of a link