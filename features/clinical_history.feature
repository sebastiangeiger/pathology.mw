Feature: Clincal history

  Scenario: Adding clincal history to a patient
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add clincal history"
    And I enter "Bloaty head, uncommon cold" into "Clincal history"
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Bloaty head, uncommon cold"
