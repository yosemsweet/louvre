Feature: Restricting community editability
  As a community owner
  I want to only allow community members to edit or create widgets
  so that I can control my content

@omniauth_test
Scenario: Trying to create a page as a non member
Given I am "Gill"
And I am authenticated
And there is a canvas
And I am on that canvas' homepage
Then I should not see "Create Page"

@omniauth_test
Scenario: Trying to access management links as a non member
  Given I am "Gill"
  And I am authenticated
  And there is a canvas
  And I am on that canvas' homepage
  Then I should not see "0 Members"
  And I should not see "Applicants"

@omniauth_test
Scenario: Trying to edit a page as a non member
  Given I am "Gill"
  And I am authenticated
  And there is a canvas
  And that canvas has a page called "Page1"
  And I am on the show page for "Page1"
  Then I should not see "Edit"

@omniauth_test
Scenario: Ability to join an open community as a non member
  Given I am "Gill"
  And I am authenticated
  And there is a canvas
  And I am on that canvas' homepage
  Then I should see a join link

@omniauth_test
Scenario: Ability to join an open community from a page as a non member
  Given I am "Bob Dole"
  And I am authenticated
  And there is a canvas
	And that canvas has a page
  And I am on that page 
  Then I should see a join link

@omniauth_test
Scenario: Joining an open community when not logged in forces login, and results in becoming a member
  Given I am "Bob Dole"
  And there is a canvas
  And I am on that canvas' homepage 
	And I am not authenticated
  When I follow the join link
	Then I should be authenticated
  And I should be a member of that canvas

@omniauth_test
Scenario: Joining an open community from a page takes you to canvas homepage
  Given I am "Bob Dole"
  And there is a canvas
	And that canvas has a page
  And I am on that page 
	And I am not authenticated
  When I follow the join link
	Then I should be on that canvas' homepage

@omniauth_test
Scenario: Joining an open community when not logged in but already a member, forces login, and message
  Given I am "Bob Dole" 
	And I am not authenticated
  And there is a canvas
  And I am a member of that canvas
  And I am on that canvas' homepage
  When I follow the join link
	Then I should be authenticated
	And I should see "You are already a member of"

@omniauth_test
Scenario: Joining an open community when not logged in but an admin, forces login, and message
  Given I am "Bob Dole" 
	And I am not authenticated
  And there is a canvas
  And I am an admin
  And I am on that canvas' homepage
  When I follow the join link
	Then I should be authenticated
	And I should see "Welcome to "	
  
@omniauth_test
Scenario: Ability to apply to a closed community as a non member
  Given I am "Gill"
  And I am authenticated
  And there is a canvas
	And that canvas is closed
  And I am on that canvas' homepage
  Then I should see "Apply"

@omniauth_test
Scenario: Ask to sign in to apply to a closed community when not logged in
  Given I am "Gill"
  And I am not authenticated
  And there is a canvas
	And that canvas is closed
  And I am on that canvas' homepage
  Then I should see "Sign in to apply"

@omniauth_test
Scenario: Make canvas closed so people have to apply to become a member
  Given there is a canvas
  And I am authenticated
  And I am an owner of that canvas
  And I am on that canvas' settings page
  And I specify that canvas should be "closed"
  When I press "Save"
  Then that canvas should require membership to edit