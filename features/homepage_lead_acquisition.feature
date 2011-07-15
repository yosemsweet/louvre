Feature: homepage_lead_acquisition
    In order to create a canvas
    People should be able to
    Get to an email signup page

Scenario:
    Given I am on the homepage
    When I fill in the following:
        | email   | gill.fert@foaca.org |
    Then I should be taken to the "Thanks for your interest" page