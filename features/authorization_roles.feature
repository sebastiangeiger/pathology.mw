Feature: Authorization Roles

  Scenario: Sign in as administrator
    Given the administrator "user@example.com" / "supersecret" exists
    When I sign in with "user@example.com" / "supersecret"
    Then I should see "user@example.com" in the top bar
    Then I should see "Administrator" in the top bar

  Scenario: Change the role of another user
    Given the administrator "admin@example.com" / "supersecret" exists
    And the guest "guest@example.com" / "supersecret" exists
    And I sign in with "admin@example.com" / "supersecret"
    When I go to the manage users page
    When I click on "guest@example.com"
    And I select "Physician" from the "Role" dropdown
    And click on "Update"
    Then "guest@example.com" should be a physician
