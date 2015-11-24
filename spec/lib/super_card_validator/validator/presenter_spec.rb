describe SuperCardValidator::Validator::Presenter do
  let(:validator) { double(:validator) }
  let(:presenter) { described_class.new(validator) }

  describe '#number' do
    let(:number) { '1234123412341' }
    before { allow(validator).to receive(:number).and_return(number) }

    it 'splits card number by four digits' do
      expect(presenter.number).to eq('1234 1234 1234 1')
    end
  end

  describe '#type' do
    before { allow(validator).to receive(:card_type).and_return(type) }
    subject { presenter.type }
    context 'when type visa' do
      let(:type) { :visa }
      it { is_expected.to eq('VISA') }
    end
    context 'when type master_card' do
      let(:type) { :master_card }
      it { is_expected.to eq('MasterCard') }
    end
    context 'when type maestro' do
      let(:type) { :maestro }
      it { is_expected.to eq('Maestro') }
    end
    context 'when type amex' do
      let(:type) { :amex }
      it { is_expected.to eq('American Express') }
    end
    context 'when type discover' do
      let(:type) { :discover }
      it { is_expected.to eq('Discover') }
    end
    context 'when type is nil' do
      let(:type) { nil }
      it { is_expected.to eq('Unknown') }
    end
  end

  describe '#valid?' do
    before { allow(validator).to receive(:valid?).and_return(is_valid) }
    subject { presenter.valid? }
    context 'when card is valid' do
      let(:is_valid) { true }
      it { is_expected.to eq(Rainbow('YES').green) }
    end
    context 'when card is not valid' do
      let(:is_valid) { false }
      it { is_expected.to eq(Rainbow('NO').red) }
    end
  end
end
