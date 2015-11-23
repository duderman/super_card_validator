Feature: My bootstrapped app kinda works
  Scenario: App just runs
    When I get help for "super_card_validator"
    Then the exit status should be 0

  Scenario: Validate action works
    When I get help for command "super_card_validator validate"
    Then the exit status should be 0


