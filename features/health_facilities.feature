Feature: HealthFacilities are submitting a specimen

  Scenario: Creating a Health Facility
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the home page
    And I click on "New Health Facility"
