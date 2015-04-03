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

  Scenario: Paginating the patient index
    Given I am signed in as a pathologist
    Given the patients 1 to 30 exist
    When I am on the patients overview page
    Then I should see "Patient #1"
    And I should see "Patient #25"
    And I should not see "Patient #26"
    When I click on "Next"
    Then I should not see "Patient #1"
    And I should not see "Patient #25"
    And I should see "Patient #26"

  Scenario: Patient edit form
    Given I am signed in as a pathologist
    Given I have created the following patient:
      | First name | Anne          |
      | Last name  | Moore         |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 14. July 1988 |
    When I go to the patient edit page for "Anne Moore"
    Then I should see "Edit 'Anne Moore'"
    Then should see the following:
      | First name | Anne          |
      | Last name  | Moore         |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 14. July 1988 |

  Scenario: Updating a patient
    Given I am signed in as a pathologist
    Given I have created the following patient:
      | First name | Anne          |
      | Last name  | Moore         |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 14. July 1988 |
    When I go to the patient edit page for "Anne Moore"
    And I fill in the following:
      | First name | Anna          |
      | Last name  | Mure          |
      | Gender     | Female        |
      | District   | Blantyre      |
      | Birthday   | 15. July 1988 |
    And I click on "Update Patient"
    Then I should be on the patient page for "Anna Mure"
