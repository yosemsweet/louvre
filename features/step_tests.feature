Feature: Test my steps
  As a developer
  I want to ensure my cucumber steps work
  So I don't have to waste time checking to see if a step is broken or if my code is broken
  
  
@background_user
Scenario: Given I am a member of that canvas
  Given there is a canvas
  And I am a member of that canvas
  Then I should be a member of that canvas

@background_user
Scenario: Given I am not a member of that canvas
  Given there is a canvas
  Then I should not be a member of that canvas

@background_user
Scenario: Given I am an admin
  Given I am an admin
  Then I should be an admin

Scenario: Given I am so and so
  Given I am "Bob Dole" 
  Then I should be "Bob Dole"
  
@omniauth_test
Scenario: Given I am so and so and authenticated
  Given I am "Bob Dole" 
  And I am authenticated
  Then I should be "Bob Dole"