Feature: Comment on widgets
  As a contributor
  I want to tell the community my viewpoint on items in the input stream
  so that I can help the community refine the contents of the widget
  
Background:
Given there is a canvas
And there is a widget

@background_user @wip
Scenario: Leave comment on widget
When I am on that canvas' homepage
Then I should see a link to comment on that widget