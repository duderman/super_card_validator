Feature: My bootstrapped app kinda works
  Scenario: App just runs
    When I get help for "super_card_validator"
    Then the exit status should be 0

  Scenario: Validate action works
    When I get help for command "super_card_validator validate"
    Then the exit status should be 0

  Scenario: Validate correct number
    When I validate number "4916430590266338" with command "super_card_validator validate"
    Then the exit status should be 0
    And output should contain "4916430590266338"
    And output should contain "VISA"
    And output should contain "YES"

  Scenario: Validate incorrect number
    When I validate number "5434264898429996" with command "super_card_validator validate"
    Then the exit status should be 1
    And output should contain "5434264898429996"
    And output should contain "MasterCard"
    And output should contain "NO"

  Scenario: Validate correct and incorrect numbers
    When I validate numbers "6011822278021475 370310215536447 123" with command "super_card_validator validate"
    Then the exit status should be 1
    And output should contain "6011822278021475"
    And output should contain "Discover"
    And output should contain "NO"
    And output should contain "370310215536447"
    And output should contain "American Express"
    And output should contain "YES"
    And output should contain "123"
    And output should contain "Unknown"
    And output should contain "NO"

