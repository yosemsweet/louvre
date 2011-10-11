Feature: Link Widgets
 As Gill
 I want to see interesting links within my canvas
 So I can find out what else is going on online with regards to my goal

Background:
  Given there is a canvas

@javascript
Scenario Outline: Link widgets display as a sourced quote on page
  Given there is a link with "<Title>", "<Link>", and "<Text>"
  When I visit a page with the link added
  Then the page should include html "<Source>"

  Examples:
  | Title           | Link                    | Text                | Source                                                                                                                     |
  | CNN             | http://www.cnn.com      | Basic Sample Text   |<blockquote cite='http://www.cnn.com'>Basic Sample Text</blockquote><p><a href='http://www.cnn.com'><cite>CNN</cite></a></p> | 
  | CNN             | http://www.cnn.com      |                     |<a href='http://www.cnn.com'><cite>CNN</cite</a>        |
  
@omniauth_test
@javascript
Scenario: Show Add Link from 
Given I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
When I follow "Post a link"
Then "the new link widget form" should be visible
