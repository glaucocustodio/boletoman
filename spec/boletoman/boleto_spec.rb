RSpec.describe Boletoman::Boleto do
  subject { described_class.new(pdf_generator_instance) }

  describe '#line' do
    let(:pdf_generator_instance) { double(:pdf_generator_instance) }

    it do
      expect(pdf_generator_instance).to(
        receive_message_chain('codigo_barras.linha_digitavel').and_return(:result)
      )
      expect(subject.line).to eq(:result)
    end
  end

  describe '#barcode' do
    let(:pdf_generator_instance) { double(:pdf_generator_instance, codigo_barras: 'codigo_barras') }

    it do
      expect(subject.barcode).to eq('codigo_barras')
    end
  end

  describe '#nosso_numero' do
    let(:pdf_generator_instance) do
      double(:pdf_generator_instance, nosso_numero_boleto: 'nosso_numero_boleto')
    end

    it do
      expect(subject.nosso_numero).to eq('nosso_numero_boleto')
    end
  end

  describe '#pdf' do
    let(:pdf_generator_instance) { double(:pdf_generator_instance, to_pdf: 'pdf') }

    it do
      expect(subject.pdf).to eq('pdf')
    end
  end
end
