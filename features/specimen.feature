Feature: Specimen

  Scenario: Adding a specimen
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "Left Eye" into "Specimen"
    And I enter "Presented with fever and N/S for 2 weeks" into "Clinical history"
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"
    And I should see "Presented with fever and N/S for 2 weeks" within ".clinical-history"
