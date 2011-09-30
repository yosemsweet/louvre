Feature: invite others to canvas
  As a canvas owner
  I want to be able to invite others to JOIN my canvas community
  So that I can grow my community

@omniauth_test
Scenario: invite other to join my canvas via facebook send
Given there is a canvas
And I am authenticated
And I am on that canvas' homepage
Then pending I can invite other to join my canvas via facebook send
