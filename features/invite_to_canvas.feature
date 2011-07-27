Feature: invite others to canvas
  As a canvas owner
  I want to be able to invite others to JOIN my canvas community
  So that I can grow my community

@omniauth_test @wip
Scenario: email others to join my canvas
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
Then I can invite other to join my canvas through email
