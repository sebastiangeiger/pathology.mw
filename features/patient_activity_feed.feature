Feature: Patient Activity Feed

  Scenario: No specimen has been added yet
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    Then I should not see "2014" within ".year"
    Then I should see "No entries"

  Scenario: Adding a specimen
    Given I am signed in as a pathologist
    And it is currently September 1 2014
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "2014-QT-133" into "Pathology #"
    And I enter "Left Eye" into "Specimen"
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye"
    And I should see "2014" within ".year"
    And I should see "No more entries"
