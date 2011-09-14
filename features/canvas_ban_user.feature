Feature: ban user
  As an community owner
  I want the ability to ban applicant's and members
  so that I can control my community

Background:
Given I am authenticated
And I am the owner of a canvas
And "Gill Fert" is a user

@omniauth_test
Scenario: View banned members
  Given I have banned "Gill Fert"
  And I am on that canvas' ban management page
  Then I should see "Gill Fert" within the banned list

@wip
@omniauth_test
Scenario: Ban link shown on canvas member page
  Given "Gill Fert" is a member of that canvas
  When I am on that canvas' member management page
  Then I should see a ban link for "Gill Fert"