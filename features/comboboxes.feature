@javascript
Feature: Fancy Javascript Comboboxes

  Background:
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists

  Scenario: Adding a new specimen with javascript
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    And I add the option "Left Eye" to the "Specimen" combobox
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"

  Scenario: Selecting a specimen from an existing list
    Given the specimen "Left Eye" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    And I enter "Eye" into the "Specimen" combobox and autocomplete the first entry
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"

  Scenario: Adding a new specimen with fallback
    Given the specimen "Left Eyelid" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    Then the entry "Left Eye" in the "Specimen" combobox is shadowed by "Left Eyelid"
    When I click on the fallback link for "Specimen"
    And I enter "Left Eye" into "Specimen"
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "Left Eye" within ".description"
