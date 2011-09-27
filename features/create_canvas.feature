Feature: Create a canvas
  As Gill
  I want to create a new canvas
  So that I can help Women of a Certain Age be Fashionable
 
@omniauth_test
Scenario: Create Canvas - authenticated
Given I am "Gill"
And I am authenticated
And I am on "the New Canvas page"
When I fill in the following:
|Name     |Fashion of a Certain Age| 
|Mission  |Better clothing for women of a certain age!|
|Image|http://www.carniola.org/theglory/images/McHammer.gif|
And I press "Save"
Then I should be on "Fashion of a Certain Age canvas homepage"
And I should see "Canvas created!"
And I should be the creator of the "Fashion of a Certain Age" canvas
And I should see "Edit"

# @omniauth_test  
# Scenario: Create a new canvae - not authenticated
#   Given I am on the homepage
#   When I follow "Create Your Own Canvas"
#   Then I should be on "the New Canvas page"
#   And I should see "Logged in"

# @omniauth_test
# Scenario: Create a new canvae - authenticated
#   Given I am on the homepage
#   And I am authenticated
#   When I follow "Create Your Own Canvas"
#   Then I should be on "the New Canvas page"

@omniauth_test
Scenario: Make canvas closed
  Given I am creating a canvas
  When I specify that canvas should be "closed"
  And I press "Save"
  Then that canvas should require membership to edit



