Feature: invite others to join my canvas
  As a canvas owner
  I want to be able to invite others to JOIN my canvas community
  So that I can grow my community

@wip
@omniauth_test  
Scenario: Canvas Invite via email 
Given there is a canvas 
And I am on that canvas' homepage
And I am authenticated
Then I can send email invites to my friends