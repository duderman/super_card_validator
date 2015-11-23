require_relative 'validator/luhn'

module SuperCardValidator
  # Main validator class
  class Validator
    CARD_TYPES = {
      visa: /^4[0-9]{12}(?:[0-9]{3})?$/,
      master_card: /^5[1-5][0-9]{14}$/,
      maestro: /^(?:5[0678]\d\d|6304|6390|67\d\d)\d{8,15}$/,
      amex: /^3[47][0-9]{13}$/,
      discover: /^6(?:011|5[0-9]{2})[0-9]{12}$/
    }.freeze

    attr_reader :number

    def initialize(number = '')
      @number = number.to_s.gsub(/\s/, '')
    end

    def valid?
      allowed_card_type? && luhn_valid?
    end

    # Returns card type of passed number
    def card_type
      @card_type ||= CARD_TYPES.keys.detect { |t| card_has_type?(t) }
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
      (CARD_TYPES[type] && number =~ CARD_TYPES[type])
    end
  end
end
