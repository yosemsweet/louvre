Feature: Provide Feedback
As Gill
I want to be able to provide feedback
So that I can help make the product better

@omniauth_test
@javascript
Scenario: Providing feedback on versions feature
Given I am authenticated
And there is a canvas
And this canvas has a page titled "Hats"
And I am on that canvas' homepage
And I follow "Hats"
And I follow "Versions"
Then I should see "May we contact you about this feature?"
And I press "Yes"
Then my feedback should be recorded
