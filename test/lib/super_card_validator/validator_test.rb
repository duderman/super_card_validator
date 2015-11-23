require 'test_helper'

require 'super_card_validator/validator'

# Tests SuperCardValidator::Validator::Luhn class
class LuhnTest < Test::Unit::TestCase
  VALID_CARDS = {
    visa: {
      numbers: %w(
        4929519728293050
        4539804862972962
        4716569423631713
      ),
      name: 'VISA'
    },
    master_card: {
      numbers: %w(
        5462893162052235
        5456771441508318
        5124906997816804
      ),
      name: 'MasterCard'
    },
    amex: {
      numbers: %w(
        376961355814210
        346603575259407
        344994331237411
      ),
      name: 'American Express'
    },
    discover: {
      numbers: %w(
        6011074725391360
        6011830785218755
        6011089758160912
      ),
      name: 'Discover'
    },
    maestro: {
      numbers: %w(
        6762169030862328
        5038708021683654
        5020050501343305
      ),
      name: 'Maestro'
    }
  }.freeze

  INVALID_NUMBERS = %w(
    123123
    3333
    6762169030862329
    346603575259408
    5456771441508317
    asdasdasd
  )

  def test_valid_cards
    VALID_CARDS.each do |type, data|
      data[:numbers].each do |number|
        validator = SuperCardValidator::Validator.new(number)
        assert(
          validator.valid?,
          "Number #{number} is not valid but should be"
        )
        assert(
          validator.card_type == type,
          "Number #{number} is #{validator.card_type} instead of #{type}"
        )
        assert(
          validator.human_card_type == data[:name],
          "Numbers #{number} human type is #{validator.human_card_type} " \
          "instead of #{data[:name]}"
        )
      end
    end
  end

  def test_invalid_cads
    INVALID_NUMBERS.each do |number|
      assert(
        !SuperCardValidator::Validator.new(number).valid?,
        "Number #{number} is valid but should not be"
      )
    end
  end

  def test_initialize
    number = '123 123 3'
    assert(
      number.gsub(/\s/, '') == SuperCardValidator::Validator.new(number).number,
      'Validator should remove all whitespaces from number on initialize'
    )
  end
end
