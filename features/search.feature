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
