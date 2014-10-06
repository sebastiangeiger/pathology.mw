Feature: Specimen

  Scenario: Searching by age (birthday)
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Date of birth      |
      | Anne Moore   | 16. June 1978      |
      | Beth Norris  | 23. September 1982 |
      | Cecilia Orth | 15. May 1983       |
    And it is currently 23. September 2014
    When I go to the search page
    And I enter "32" into "Maximum age"
    And I click on "Search"
    Then I should not see "Anne Moore"
    Then I should see "Beth Norris"
    Then I should see "Cecilia Orth"

  Scenario: Searching by age (birthyear)
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Birthyear |
      | Anne Moore   | 1980      |
      | Beth Norris  | 1981      |
      | Cecilia Orth | 1982      |
    And it is currently 23. September 2014
    When I go to the search page
    And I enter "32" into "Maximum age"
    And I click on "Search"
    Then I should not see "Anne Moore"
    Then I should see "Beth Norris"
    Then I should see "Cecilia Orth"

  Scenario: Showing the search values
    Given I am signed in as a pathologist
    When I go to the search page
    And I enter "32" into "Maximum age"
    And I click on "Search"
    Then I should see "32" in "Maximum age"
    And "Minimum age" should be empty

  Scenario: Searching by gender
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Gender  |
      | Anne Moore   | Female  |
      | John Doe     | Male    |
    And it is currently 23. September 2014
    When I go to the search page
    And I enter "Female" into "Gender"
    And I click on "Search"
    Then I should see "Anne Moore"
    Then I should not see "John Doe"

  Scenario Outline: Searching by name
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         |
      | Anne Moore   |
      | John Doe     |
    When I go to the search page
    And I enter "<Search Term>" into "Name"
    And I click on "Search"
    Then I should not see "Anne Moore"
    Then I should <should see?> "John Doe"

    Examples:
      | Search Term | should see? |
      | John Doe    | see         |
      | Jon Doe     | see         |
