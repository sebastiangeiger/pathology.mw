Feature: Patient Management

  Scenario: Add a new patient
    Given I am signed in as a pathologist
    When I am on the patients overview page
    And I click on "New Patient"
    And I fill in the following:
      | First name | Anne          |
      | Last name  | Moore         |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 14. July 1988 |
    And I click on "Create Patient"
    Then I should be on the patient page for "Anne Moore"

  Scenario: Showing errors
    Given I am signed in as a pathologist
    When I am on the patients overview page
    And I click on "New Patient"
    And I fill in the following:
      | First name | Anne          |
    And I click on "Create Patient"
    Then I should see "Could not create the Patient"
    And I should see "can't be blank"

