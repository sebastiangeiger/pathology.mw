Feature: Specimen

  Scenario: Adding a specimen
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I fill in the following:
      | Pathology #      | 2014-QT-204                              |
      | Specimen         | Left Eye                                 |
      | Clinical history | Presented with fever and N/S for 2 weeks |
      | Gross            | Gross results here                       |
      | Stains           | Stains here                              |
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
    And I should see "Left Eye" within ".description"
    And I should see "Presented with fever and N/S for 2 weeks" within ".clinical-history"
    And I should see "Gross results here" within ".gross"
    And I should see "Stains here" within ".stains"

  @javascript
  Scenario: Prepopulated Pathology #
    Given I am signed in as a pathologist
    And it is currently September 1 2014
    And the patient "Anne Moore" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I enter "204" into "Pathology #"
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
