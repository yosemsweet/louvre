Feature: ban user
  As an community owner
  I want the ability to ban applicant's and members
  so that I can control my community

@omniauth_test
Scenario: View banned members
  Given I am authenticated
  And I am the owner of a canvas
  And "Gill Fert" is a user
  And I have banned "Gill Fert"
  And I am on that canvas' ban management page
  Then I should see "Gill Fert" within the banned list