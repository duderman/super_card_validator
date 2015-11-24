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
    And output should be
        """
        NUMBER              | TYPE | VALID?
        --------------------|------|-------
        4916 4305 9026 6338 | VISA | YES   

        All cards are valid!

        """

  Scenario: Validate incorrect number
    When I validate number "5434264898429996" with command "super_card_validator validate"
    Then the exit status should be 1
    And output should be
        """
        NUMBER              | TYPE       | VALID?
        --------------------|------------|-------
        5434 2648 9842 9996 | MasterCard | NO    

        error: Some cards are invalid. Check output for more info

        """

  Scenario: Validate correct and incorrect numbers
    When I validate numbers "6011822278021475 370310215536447 123" with command "super_card_validator validate"
    Then the exit status should be 1
    And output should be
        """
        NUMBER              | TYPE             | VALID?
        --------------------|------------------|-------
        6011 8222 7802 1475 | Discover         | NO    
        3703 1021 5536 447  | American Express | YES   
        123                 | Unknown          | NO    

        error: Some cards are invalid. Check output for more info

        """
