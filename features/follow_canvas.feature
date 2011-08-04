Feature: canvas homepage
  As a member of asaucybook
  I want to see canvae that I'm interested in
  So I can easily participate in their communities

Background:
  Given there is a canvas
  And I am authenticated
  And I am on that canvas' homepage

@omniauth_test
@javascript
Scenario: Follow a canvas
  Then I should see the "Follow" button
  When I press "Follow"
  Then I should not see the "Follow" button
  And I should see "Following"
  When I reload the page
  Then I should see "Following"

@omniauth_test
@javascript
Scenario: Stop following a canvas
  Given I press "Follow"
  And I reload the page
  Then I should see the "Stop following" button
  When I press "Stop following"
  Then I should not see the "Stop following" button
  And I should see the "Follow" button