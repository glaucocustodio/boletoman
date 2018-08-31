RSpec.describe Boletoman::Services::Itau::Boleto::Response do
  subject { described_class.new(raw) }

  describe '#error?' do
    context 'has error' do
      let(:raw) { double(:raw, status: 400, body: {}.to_json) }

      it do
        expect(subject.error?).to eq(true)
      end
    end

    context 'no error' do
      let(:raw) { double(:raw, status: 200, body: {}.to_json) }

      it do
        expect(subject.error?).to eq(false)
      end
    end
  end

  describe '#barcode' do
    let(:raw) { double(:raw, body: { codigo_barras: 'codigo_barras' }.to_json, status: :whatever) }

    it do
      expect(subject.barcode).to eq('codigo_barras')
    end
  end

  describe '#line' do
    let(:raw) { double(:raw, body: { numero_linha_digitavel: 'linha' }.to_json, status: :whatever) }

    it do
      expect(subject.line).to eq('linha')
    end
  end

  describe '#nosso_numero' do
    let(:raw) { double(:raw, body: { nosso_numero: '123456789' }.to_json, status: :whatever) }

    it do
      expect(subject.nosso_numero).to eq('12345678')
    end
  end
end
