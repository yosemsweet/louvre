Feature: Comment on widgets
  As a contributor
  I want to tell the community my viewpoint on items in the input stream
  so that I can help the community refine the contents of the widget
  
Background:
Given there is a canvas
And there is an input stream widget

@wip
@background_user
Scenario: Discuss link for widgets
When I am on that canvas' homepage
Then I should see a link to comment on that widget


@omniauth_test
Scenario: Leave comment on widget
Given I am authenticated
When I am on that widget's page
And I fill in "comment_content" with "This would be very useful"
And I press "add comment"
Then I should see "This would be very useful"