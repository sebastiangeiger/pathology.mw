Feature: Physicians are submitting a specimen

  Scenario: Creating a physician
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the home page
    And I click on "New Physician"
    And I fill in the following:
      | Title      | Dr.     |
      | First name | Julius  |
      | Last name  | Hibbert |
    And I click on "Create"
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I fill in the following:
      | Pathology # | 2014-QT-204        |
      | Physician   | Dr. Julius Hibbert |
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
    And I should see "Dr. Julius Hibbert" within ".physician-name"
