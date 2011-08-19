Feature: canvas homepage
  As a member of loorp
  I want to see canvae that I'm interested in
  So I can easily participate in their communities

Background:
  Given there is a canvas
  And I am authenticated
  And I am on that canvas' homepage

@omniauth_test
@javascript
@wip
Scenario: Follow a canvas
  Then I should see the "follow" image
  When I follow "follow"
  Then I should not see the "follow" image
  And I should be following
 
@omniauth_test
@javascript
@wip
Scenario: Stop following a canvas
  Given I follow "follow"
  Then I should see the "unfollow" image
  When I follow "unfollow"
  Then I should not see the "unfollow" image
  And I should not be following 