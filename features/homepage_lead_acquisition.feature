Feature: homepage_lead_acquisition
    In order to create a canvas
    People should be able to
    Get to an email signup page

Scenario:
    Given I am on the homepage
    When I fill in the following:
        | email   | gill.fert@foaca.org |
    And I press "submit"
    Then I should be on the "Thanks for your interest" page

Scenario:
    Given I am on the homepage
    Then I should see the logo
    
Scenario:
    Given I am on the homepage
    Then I should see an intro video
    
Scenario:
    Given I am on the homepage
    Then the page title should be "A Saucy Book"