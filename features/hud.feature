Feature: user hud
  As a member of loorp
  I want to see canvae that I'm interested in
  So I can easily participate in their communities

@wip
@omniauth_test
@javascript  
Scenario: Listing followed canvases
  Given there is a canvas
  And I am authenticated 
  And I am on that canvas' homepage
  When I press "Follow" 
  And I follow "Hud"
  And I wait a second
  Then I should see the hud
  And I should see that canvas' name in the hud
  
  