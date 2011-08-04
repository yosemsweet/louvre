Feature: homepage
    In order to create a canvas
    People should be able to
    Get to an email signup page

Scenario:
    Given I am on the homepage
    Then I should see the logo
    And the page title should be "A Saucy Book"
    And I should see "Alpha"
    And I should see recent canvases
