Feature: Create a canvas
  As Gill
  I want to create a new canvas
  So that I can help Women of a Certain Age be Fashionable
 
@omniauth_test
Scenario: Going to new canvas url creates a canvas if you authenticated
  Given I am "Gill"
  And I am authenticated
  When I go to the new canvas page
  Then I should be on that canvas' homepage
  And I should be an owner of that canvas

@omniauth_test  
Scenario: Create a new canvae - not authenticated
  Then pending supported by canvae_controller_spec
