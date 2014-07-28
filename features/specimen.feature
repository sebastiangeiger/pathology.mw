Feature: Clincal history

  Scenario: Adding clincal history to a patient
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "Left Eye" into "Specimen"
    Then show me the page
