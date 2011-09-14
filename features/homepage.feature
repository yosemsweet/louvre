Feature: homepage
    In order to create a canvas
    People should be able to
    Get to an email signup page

Background:
    Given I am on the homepage

Scenario: Homepage logo
    Then I should see the logo
    
Scenario: Homepage title
    Then the page title should be "Loorp!"
    
Scenario: Show recent canvae
    Then I should see recent canvases


  
  