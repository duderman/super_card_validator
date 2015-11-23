module SuperCardValidator
  class Validator
    # Validates number against Luhn algorithm
    class Luhn
      attr_reader :number

      def initialize(number)
        @number = number
      end

      def valid?
        checksum % 10 == 0
      end

      private

      def checksum
        luhn_doubled.inject(0) { |a, e| a + sum_of(e) }
      end

      def luhn_doubled
        split_digits(number).reverse
          .map.with_index do |n, i|
            i.odd? ? n * 2 : n
          end.reverse
      end

      def split_digits(number)
        number.to_s.split(//).map(&:to_i)
      end

      def sum_of(number)
        split_digits(number).inject(:+)
      end
    end
  end
end
