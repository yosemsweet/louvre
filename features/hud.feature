Feature: user hud
  As a member of asaucybook
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
  Then I should see "Your Hud"
  And I should see a that canvas' name
  