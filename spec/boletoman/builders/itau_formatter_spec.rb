RSpec.describe Boletoman::Builders::ItauFormatter do
  subject { described_class.new(raw) }

  describe '#checking_account' do
    let(:raw) { { transferor: { checking_account: "45129" } } }

    it do
      expect(subject.checking_account).to eq('4512')
    end
  end
end
