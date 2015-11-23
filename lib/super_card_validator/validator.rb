require 'rainbow'

require_relative 'validator/luhn'

module SuperCardValidator
  # Main validator class
  class Validator
    CARD_TYPES = {
      visa: {
        regex: /^4[0-9]{12}(?:[0-9]{3})?$/,
        name: 'VISA'
      },
      master_card: {
        regex: /^5[1-5][0-9]{14}$/,
        name: 'MasterCard'
      },
      maestro: {
        regex: /^(?:5[0678]\d\d|6304|6390|67\d\d)\d{8,15}$/,
        name: 'Maestro'
      },
      amex: {
        regex: /^3[47][0-9]{13}$/,
        name: 'American Express'
      },
      discover: {
        regex: /^6(?:011|5[0-9]{2})[0-9]{12}$/,
        name: 'Discover'
      }
    }.freeze

    attr_reader :number

    def initialize(number = '')
      @number = number.to_s.gsub(/\s/, '')
    end

    def valid?
      allowed_card_type? && luhn_valid?
    end

    def invalid?
      !valid?
    end

    # Returns card type of passed number
    def card_type
      @card_type ||= CARD_TYPES.keys.detect { |t| card_has_type?(t) }
    end

    # Returns card type of passed number
    def human_card_type
      if card_type.nil?
        'Unknown'
      else
        CARD_TYPES[card_type][:name]
      end
    end

    # Returns colored by Rainbow human-readable validity
    def colored_human_valid
      valid? ? Rainbow('YES').green : Rainbow('NO').red
    end

    private

    def allowed_card_type?
      !card_type.nil?
    end

    def luhn_valid?
      return @luhn_valid unless @luhn_valid.nil?
      @luhn_valid = Luhn.new(number).valid?
    end

    def card_has_type?(type)
      type = type.to_sym
      (CARD_TYPES[type] && number =~ CARD_TYPES[type][:regex])
    end
  end
end
