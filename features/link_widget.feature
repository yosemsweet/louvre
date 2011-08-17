Feature: Link Widgets
 As Gill
 I want to see interesting links within my canvas
 So I can find out what else is going on online with regards to my mission

Background:
  Given there is a canvas

@javascript
Scenario Outline: Link widgets display as a sourced quote on page
  Given there is a link with "<Title>", "<Link>", and "<Text>"
  When I visit a page with the link added
  Then the page should include html "<Quote>"

  Examples:
  | Title           | Link                    | Text                | Quote                                                                                                                     |
  | CNN             | http://www.cnn.com      | Basic Sample Text   |<blockquote cite='http://www.cnn.com'>Basic Sample Text</blockquote><p class='source'><a href='http://www.cnn.com'><cite>CNN</cite></a></p> | 
  
@omniauth_test
@javascript
Scenario: Show Add Link from 
Given I am authenticated
And I am on that canvas' homepage
When I follow "Add Link"
Then I should see the new widget form
