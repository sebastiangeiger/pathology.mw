Feature: Authorization Roles

  Scenario: Sign in as administrator
    Given the administrator "user@example.com" / "supersecret" exists
    When I sign in with "user@example.com" / "supersecret"
    Then I should see "user@example.com" in the top bar
    Then I should see "Administrator" in the top bar


