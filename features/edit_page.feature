Feature: Edit Page

As Gill
I want to be able to edit a page
So that I can refine it to make it better

Scenario: Moving Widgets
	Given I am on a page
	And the page has 2 widgets
	And I press "Edit"
	When I click and drag a widget to a new spot on the page
	And I press "Save"
	Then the page should save the changes
	
Scenario:	
	Given I am on a page
	And the page has a widget
	And I press "Edit Widget"
	When WYSIWYG form appears with the Widget text pre-populated
	And I fill in "hello world"
	And I press "Save Widget"
	Then "hello world" should appear on the page
	
Scenario:
	Given I am on a page
	When I press "Edit Title"
	And I fill in "MC Hammer" for "Title"
	And click "Save Title"
	Then "Title" should be "MC Hammer" 