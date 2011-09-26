Feature: homepage
    In order to create a canvas
    People should be able to
    Get to an email signup page

Background:
    Given I am on the homepage
    
Scenario: Homepage title
    Then the page title should be "Loorp!"

Scenario: Homepage has a call to action
    Then I should see "Try It For Free!"
  

  
  