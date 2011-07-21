Feature: add input via bookmarklet
As Gill Fert 
I want to add content to my canvas input stream via bookmarklets 
so that I can share interesting information with my friends

Background: 
  Given I am "Gill Fert"

Scenario: Use bookmarklet from a web page adds to input stream
Given I am browsing "cnn"
And I have a canvas bookmarklet
When I use the bookmarklet
Then the webpage link is added to the canvas' input stream

Scenario: Use invalid bookmarklet from a web page returns an error
Given I am browsing ""
And I have a canvas bookmarklet
When I use the bookmarklet
Then I see an error

