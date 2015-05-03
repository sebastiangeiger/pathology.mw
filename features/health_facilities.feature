Feature: HealthFacilities are submitting a specimen

  Scenario: Creating a Health Facility
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the home page
    And I click on "New Health Facility"
    And I fill in the following:
      | Name           | QECH       |
      | Postal address | Po Box 360 |
      | Telephone      | 0999383333 |
      | District       | Blantyre   |
