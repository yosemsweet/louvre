Feature: user menu
  As a member of loorp
  I want to see canvae that I'm following
  So I can easily participate in those communities

@omniauth_test
@javascript
Scenario: Listing followed canvases
  Given there is a canvas
  And I am authenticated 
  And I am on that canvas' homepage
  When I follow "follow"
  And I follow "Hud"
  Then I should see the hud
  And I should see that canvas' name in the hud

@wip  
@omniauth_test
@javascript
Scenario: Show the canvases that I am a part of
  Given I am a member of 2 canvae
  And I am authenticated 
  And I am on the homepage
  When I click on the communities menu
  Then I should see links to those canvae within the communities menu
  
  