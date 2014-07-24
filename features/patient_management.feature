Feature: Patient Management

  Scenario: Add a new patient
    Given I am signed in as a pathologist
    When I am on the patients overview page
    And I click on "New Patient"
    And I fill in the following:
      | First Name | Anne          |
      | Last Name  | Moore         |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 14. July 1988 |
    And I click on "Create Patient"
    Then I should be on the patients overview page
    And I should see "Patient Anne Moore has been created"

