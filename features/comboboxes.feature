@javascript
Feature: Fancy Javascript Comboboxes

  Scenario: Adding a new specimen with javascript
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    And I add the option "Left Eye" to the "Specimen" combobox
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"

  Scenario: Selecting a specimen from an existing list
    Given I am signed in as a pathologist
    And the specimen "Left Eye" exists
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    And I enter "Eye" into the "Specimen" combobox and autocomplete the first entry
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"
