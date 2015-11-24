describe SuperCardValidator::Validator::Luhn do
  describe '#valid?' do
    let(:numbers) do
      %w(
        4575120746827172
        5261507907508979
        369585362892569
        6011482336137108
        4929519728293050
        4539804862972962
        4716569423631713
        4929519728293050
      ).freeze
    end

    context 'with correct numbers' do
      it 'returns true' do
        numbers.each do |number|
          expect(described_class.new(number).valid?).to be(true)
        end
      end
    end

    context 'with incorrect numbers' do
      let(:spoiled_numbers) do
        numbers.map { |n| "#{n[0..-2]}#{(n[-1].to_i + 1) % 10}" }
      end

      it 'returns true' do
        spoiled_numbers.each do |number|
          expect(described_class.new(number).valid?).to be(false)
        end
      end
    end
  end

  describe '#checksum' do
    let(:numbers) do
      {
        '4024007156386004' => 50,
        '5248283272408512' => 70,
        '6011374888562892' => 80,
        '348199369901245' => 80
      }
    end

    it 'returns correct checksum' do
      numbers.each do |number, checksum|
        expect(described_class.new(number).checksum).to eq(checksum)
      end
    end
  end
end
