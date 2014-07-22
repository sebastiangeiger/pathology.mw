Feature: Authorization Roles

  Scenario: Sign in as administrator
    Given the user "user@example.com" / "supersecret" exists
    And "user@example.com" is an administrator
    When I sign in with "user@example.com" / "supersecret"
    Then I should see "user@example.com" in the top bar
    Then I should see "Administrator" in the top bar

