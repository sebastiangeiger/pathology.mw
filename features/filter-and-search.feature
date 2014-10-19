Feature: Filter and search

  Scenario: Filtering by age (birthday)
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Date of birth      |
      | Anne Moore   | 16. June 1978      |
      | Beth Norris  | 23. September 1982 |
      | Cecilia Orth | 15. May 1983       |
    And it is currently 23. September 2014
    And I am on the patients overview page
    When I enter "32" into "Maximum age"
    And I click on the "Filter" button
    Then I should not see "Anne Moore"
    Then I should see "Beth Norris"
    Then I should see "Cecilia Orth"

  Scenario: Filtering by age (birthyear)
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Birthyear |
      | Anne Moore   | 1980      |
      | Beth Norris  | 1981      |
      | Cecilia Orth | 1982      |
    And it is currently 23. September 2014
    And I am on the patients overview page
    When I enter "32" into "Maximum age"
    And I click on the "Filter" button
    Then I should not see "Anne Moore"
    Then I should see "Beth Norris"
    Then I should see "Cecilia Orth"

  Scenario: Showing the filter values
    Given I am signed in as a pathologist
    And I am on the patients overview page
    When I enter "32" into "Maximum age"
    And I click on the "Filter" button
    Then I should see "32" in "Maximum age"
    And "Minimum age" should be empty

  Scenario: Filtering by gender
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         | Gender  |
      | Anne Moore   | Female  |
      | John Doe     | Male    |
    And it is currently 23. September 2014
    And I am on the patients overview page
    When I enter "Female" into "Gender"
    And I click on the "Filter" button
    Then I should see "Anne Moore"
    Then I should not see "John Doe"

  Scenario Outline: Searching by name
    Given I am signed in as a pathologist
    And the following patients exist:
      | Name         |
      | Anne Moore   |
      | John Doe     |
    And I am on the patients overview page
    When I enter "<Search Term>" into "Name"
    And I click on the "Search" button
    Then I should not see "Anne Moore"
    Then I should <should see?> "John Doe"

    Examples:
      | Search Term | should see? |
      | John Doe    | see         |
      | Jon Doe     | see         |
