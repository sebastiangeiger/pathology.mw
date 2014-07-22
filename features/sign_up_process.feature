Feature: Sign up users

  Scenario: New user wants to sign up
    Given there are no users
    When I go to the home page
    And I click on "Sign up"
    And I fill "Email" with "user@example.com"
    And I fill "Password" with "supersecret"
    And I fill "Password confirmation" with "supersecret"
    And I click on "Sign up"
    Then I should be on the sign in page
    And I should see "A message with a confirmation link has been sent to your email address."

  Scenario: Need to confirm email first
    Given I signed up with "user@example.com" / "supersecret"
    When I go to the sign in page
    And I fill "Email" with "user@example.com"
    And I fill "Password" with "supersecret"
    And I click on "Sign in"
    Then I should still be on the sign in page
    And I should see "You have to confirm your account before continuing."

  Scenario: I can sign in after I confirmed
    Given I signed up with "user@example.com" / "supersecret"
    When I click on the confirmation link in the email for "user@example.com"
    Then I should see "Your account was successfully confirmed"
    Then I should be on the sign in page
    When I sign in with "user@example.com" / "supersecret"
    Then I should be on the home page
