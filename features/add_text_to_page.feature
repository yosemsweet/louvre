@pending
Feature: Add Text to Page

As Gill
I want to be able to add chunks of text to my page
so that i can describe whatever I am interested in describing

Background:
	Given there is a canvas 
	And this canvas has a page titled "Pants no one should wear"
#	And I am on "Pants no one should wear"
@pending		
Scenario: WYSIWYG Editor
#	When I follow "Edit Page"
  	Then a div with a form should appear
  	And it should contain a WYSIWYG editor
@pending
Scenario: Save Edits
#	When I follow "Edit Page"
#  	And I fill in "edit_form" with "MC Hammer is awesome!"
  	And I press the "save button"
  	Then I should see a "You have successfully edited the page!" pop-up
  	And "MC Hammer is awesome!" should be on the "page"
@pending
Scenario: Adding to a Page
  	When the "page" already has some text
  	And I follow "Edit Page"
  	And I fill in "edit_form" with "yes he is!"
  	And I press the "save button"
  	Then "yes he is!" should be added to the bottom of the "page"


  