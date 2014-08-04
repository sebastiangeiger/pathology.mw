Feature: Entering a (approximate) birthday for a patient

  @javascript
  Scenario Outline: Different ways to enter the age
    Given I am signed in as a pathologist
    When I am on the patients overview page
    And I click on "New Patient"
    And I fill in the following:
      | First name                   | Anne          |
      | Last name                    | Moore         |
      | Gender                       | Female        |
      | District                     | Blantyre      |
      | Birthday                     | <Birthday>    |
      | Age                          | <Age>         |
      | Birthday and age are unknown | <Age unknown> |
    And I click on "Create Patient"
    Then I should be on the patient page for "Anne Moore"
    Then I should see "<Displayed Age>" within ".age"

    Examples:
        | Birthday      | Age | Age unknown | Displayed Age          |
        | 14. July 1988 |     | false       | 26 (born July 14 1988) |
        |               | 26  | false       | 26 (born in 1988)      |
        |               |     | true        | not set                |

  @javascript
  Scenario: Not entering any age is invalid
    Given I am signed in as a pathologist
    And there are no patients in the system
    When I am on the patients overview page
    And I click on "New Patient"
    And I fill in the following:
      | First name                   | Anne     |
      | Last name                    | Moore    |
      | Gender                       | Female   |
      | District                     | Blantyre |
      | Birthday and age are unknown | false    |
    And I click on "Create Patient"
    Then I should see "New Patient" in the headline
    And I should see "Please select one of the three options:"
    Then there should be no patients in the system

  @javascript
  Scenario: Age input field updates automatically
    Given I am signed in as a pathologist
    When I am on the patients overview page
    And I click on "New Patient"
    When I fill "Birthday" with "14. July 1988"
    Then the value of the "Age" input field should be "26"
