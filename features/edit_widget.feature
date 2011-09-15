Feature: Editing a widget
As Gill Fert
I want to be able to edit a widget
so that I can make sure my information is valid

@omniauth_test
@javascript
Scenario: Editing a widget
Given there is a canvas
And that canvas has a question widget
And I am authenticated
And I am a member of that canvas
And I am on that canvas' homepage
When I follow "edit"
And I fill in "widget_question" with "what?"
And I click "#widget_submit"
Then I should see "what?" within ".question"