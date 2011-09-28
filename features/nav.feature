Feature: user menu
  As a member of loorp
  I want to see canvae that I'm following
  So I can easily participate in those communities

@omniauth_test
@javascript
Scenario: Show the canvases that I am a part of
  Given I am authenticated 
  And I am a member of 2 canvae
  And I am on the homepage
  When I mouse over "the communities menu"
  Then I should see links to those canvae within the communities menu

  