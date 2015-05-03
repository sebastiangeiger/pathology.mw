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
    And I click on "Create"
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I fill in the following:
      | Pathology #     | 2014-QT-204 |
      | Health facility | QECH        |
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
    And I should see "QECH" within ".health-facility-name"
