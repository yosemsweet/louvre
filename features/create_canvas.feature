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
Scenario: A new canvas has a set of default attributes
  Given I am "Bob Dole" 
  And I am authenticated
  And I've created a new canvas
  Then that canvas should be named "Bob Dole's Community"
  And that canvas should have an example widget

@omniauth_test  
Scenario: Create a new canvae - not authenticated
  Then pending supported by canvae_controller_spec

@blocked
@omniauth_test
Scenario: After canvas is created by first time canvas creator, lightbox orientation div should show up 
#   Given I am authenticated
#   And I am the owner of a canvas
#   When I go to that canvas' homepage
#   Then I should see an orientation box

