Feature: Sign up users

  Scenario: New user wants to sign up
    Given there are no users
    When I go to the home page
    And I click on "Sign up"
    And I fill "Email" with "user@example.com"
    And I fill "Password" with "supersecret"
    And I fill "Password confirmation" with "supersecret"
    And I click on "Sign up"
    Then there should be 1 user
