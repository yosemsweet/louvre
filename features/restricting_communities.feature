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
Then I should not see "Members"
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
Scenario: Ability to join a closed community as a non member
Given I am "Gill"
And I am authenticated
And there is a canvas
And I am on that canvas' homepage
Then I should see "Join"

@omniauth_test
Scenario: Make canvas closed so people have to apply to become a member
  Given there is a canvas
  And I am authenticated
  And I am an owner of that canvas
  And I am on that canvas' settings page
  And I specify that canvas should be "closed"
  When I press "Save"
  Then that canvas should require membership to edit



