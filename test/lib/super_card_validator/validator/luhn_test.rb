require 'test_helper'

require 'super_card_validator/validator/luhn'

# Tests SuperCardValidator::Validator::Luhn class
class LuhnTest < Test::Unit::TestCase
  TEST_NUMBERS = %w(
    4575120746827172
    5261507907508979
    369585362892569
    6011482336137108
    4929519728293050
    4539804862972962
    4716569423631713
  )
  def test_valid_numbers
    TEST_NUMBERS.each do |number|
      assert(
        SuperCardValidator::Validator::Luhn.new(number).valid?,
        "Number #{number} is not valid but should be"
      )
    end
  end

  def test_invalid_numbers
    TEST_NUMBERS.each do |number|
      spoiled_number = spoil_number(number)
      assert(
        !SuperCardValidator::Validator::Luhn.new(spoiled_number).valid?,
        "Number #{spoiled_number} is valid but should not be"
      )
    end
  end

  private

  # Spoil number by adding one to last digit
  def spoil_number(number)
    "#{number[0..-2]}#{(number[-1].to_i + 1) % 10}"
  end
end
