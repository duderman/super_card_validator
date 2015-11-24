require 'rainbow'

module SuperCardValidator
  class Validator
    # Presents card number info in human-readable format
    class Presenter
      # Contains card types translations
      CARD_TYPES_NAMES = {
        visa: 'VISA',
        master_card: 'MasterCard',
        maestro: 'Maestro',
        amex: 'American Express',
        discover: 'Discover'
      }.freeze

      def initialize(validator)
        @validator = validator
      end

      def number
        @validator.number.scan(/.{1,4}/).join(' ')
      end

      # Returns human-readable card type
      def type
        CARD_TYPES_NAMES[@validator.card_type] || 'Unknown'
      end

      # Returns colored by Rainbow human-readable validity flag
      def valid?
        @validator.valid? ? Rainbow('YES').green : Rainbow('NO').red
      end
    end
  end
end
