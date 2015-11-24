describe SuperCardValidator::Validator do
  describe '.initialize' do
    let(:number) { '123 123 123' }
    subject { described_class.new(number) }

    it 'removes all whitespaces from number on initialize' do
      expect(subject.number).to eq(number.gsub(/\s/, ''))
    end
  end

  describe '#valid?' do
    context 'with valid card numbers' do
      let(:numbers) do
        %w(
          4929519728293050
          5462893162052235
          376961355814210
          6011074725391360
          6762169030862328
        ).freeze
      end

      it 'returns true' do
        numbers.each do |number|
          expect(described_class.new(number).valid?).to be(true)
        end
      end
    end

    context 'with invalid numbers' do
      let(:numbers) do
        %w(
          123123
          3333
          6762169030862329
          346603575259408
          5456771441508317
          asdasdasd
        ).freeze
      end

      it 'returns false' do
        numbers.each do |number|
          expect(described_class.new(number).valid?).to be(false)
        end
      end
    end
  end

  describe '#card_type' do
    context 'with valid numbers' do
      let(:numbers) do
        {
          '4539804862972962' => :visa,
          '5456771441508318' => :master_card,
          '346603575259407' => :amex,
          '6011830785218755' => :discover,
          '5038708021683654' => :maestro
        }.freeze
      end

      it 'returns correct card_type' do
        numbers.each do |number, type|
          expect(described_class.new(number).card_type).to eq(type)
        end
      end
    end

    context 'with invalid numbers' do
      it 'returns nil' do
        expect(described_class.new('123').card_type).to be_nil
      end
    end
  end
end
