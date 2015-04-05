Feature: Specimen

  Scenario: Adding a specimen
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    And the physician "Dr. Julius Hibbert" exists
    When I go to the patient page for "Anne Moore"
    And I click on "Add specimen"
    And I fill in the following:
      | Pathology #      | 2014-QT-204                              |
      | Specimen         | Left Eye                                 |
      | Physician        | Dr. Julius Hibbert                       |
      | Clinical history | Presented with fever and N/S for 2 weeks |
      | Gross            | Gross results here                       |
      | Stains           | Stains here                              |
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
    And I should see "Left Eye" within ".description"
    And I should see "Dr. Julius Hibbert" within ".physician-name"
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

  Scenario: Specimen edit form
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    And the physician "Dr. Julius Hibbert" exists
    And I have create the following specimen for "Anne Moore":
      | Pathology #      | 2014-QT-204                              |
      | Specimen         | Left Eye                                 |
      | Physician        | Dr. Julius Hibbert                       |
      | Clinical history | Presented with fever and N/S for 2 weeks |
      | Gross            | Gross results here                       |
      | Stains           | Stains here                              |
    When I go to the patient page for "Anne Moore"
    And I click on "Edit specimen"
    Then I should see "Edit specimen '2014-QT-204'"
    And should see the following:
      | Pathology #      | 2014-QT-204                              |
      | Specimen         | Left Eye                                 |
      | Physician        | Dr. Julius Hibbert                       |
      | Clinical history | Presented with fever and N/S for 2 weeks |
      | Gross            | Gross results here                       |
      | Stains           | Stains here                              |

  Scenario: Updating a specimen
    Given I am signed in as a pathologist
    And the patient "Anne Moore" exists
    And the physician "Dr. Julius Hibbert" exists
    And the physician "Dr. Nicholas Riviera" exists
    And I have create the following specimen for "Anne Moore":
      | Pathology #      | 2014-QT-204                              |
      | Specimen         | Left Eye                                 |
      | Physician        | Dr. Julius Hibbert                       |
      | Clinical history | Presented with fever and N/S for 2 weeks |
      | Gross            | Gross results here                       |
      | Stains           | Stains here                              |
    When I go to the patient page for "Anne Moore"
    And I click on "Edit specimen"
    And I fill in the following:
      | Specimen         | Right Eye                |
      | Physician        | Dr. Nicholas Riviera     |
      | Gross            | Gross results changed    |
      | Stains           | Stains changed           |
      | Clinical history | Clinical history changed |
    And I click on "Save"
    Then I should be on the patient page for "Anne Moore"
    And I should see "2014-QT-204" within ".pathology-number"
    And I should see "Right Eye" within ".description"
    And I should see "Clinical history changed" within ".clinical-history"
    And I should see "Gross results changed" within ".gross"
    And I should see "Dr. Nicholas Riviera" within ".physician-name"
    And I should see "Stains changed" within ".stains"
