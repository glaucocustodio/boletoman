RSpec.describe Boletoman::Builders::Base do
  subject { described_class.new(data) }
  let(:data) { double(:data) }

  describe '#build' do
    let(:instance) { double(:instance) }

    it do
      expect(subject).to receive(:instance).and_return(instance)
      expect(instance).to receive(:to_pdf).and_return(:pdf)
      expect(subject.build).to eq(:pdf)
    end
  end

  describe '#instance' do
    it do
      expect { subject.instance }.to raise_error(NotImplementedError)
    end
  end

  describe '.generator' do
    it do
      expect(described_class.generator).to eq('base')
    end
  end

  describe '#duplicate?' do
    let(:data) { { boleto: { duplicate: true } } }
    it do
      expect(subject.duplicate?).to eq(true)
    end
  end
end
