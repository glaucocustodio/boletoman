RSpec.describe Boletoman::Services::Santander::Boleto::TicketFormatter do
  subject { described_class.new(raw) }

  describe '#document_type' do
    context 'is person' do
      let(:raw) { { payer: { document: ' 13906305015' } } }
      it do
        expect(subject.document_type).to eq("01")
      end
    end

    context 'is company' do
      let(:raw) { { payer: { document: '06288748000118' } } }
      it do
        expect(subject.document_type).to eq("02")
      end
    end
  end

  describe '#document' do
    let(:raw) { { payer: { document: '123456.789-0' } } }
    it do
      expect(subject.document).to eq('1234567890')
    end
  end

  describe '#payer_name' do
    let(:raw) { { payer: { name: 'PEDRO DE ALCÂNTARA FRANCISCO ANTÔNIO JOÃO CARLOS XAVIER' } } }
    it do
      expect(subject.payer_name).to eq('PEDRO DE ALCÂNTARA FRANCISCO ANTÔNIO JOÃ')
    end
  end

  describe '#payer_street' do
    let(:raw) { { payer: { street: 'Rua Comendador João do nome mais longo da cidade' } } }
    it do
      expect(subject.payer_street).to eq('Rua Comendador João do nome mais longo d')
    end
  end

  describe '#payer_neighborhood' do
    let(:raw) { { payer: { neighborhood: 'Conjunto habitacional do nome grande' } } }
    it do
      expect(subject.payer_neighborhood).to eq('Conjunto habitacional do nome ')
    end
  end

  describe '#payer_city' do
    let(:raw) { { payer: { city: 'Cidade de São José dos Campos' } } }
    it do
      expect(subject.payer_city).to eq('Cidade de São José d')
    end
  end

  describe '#payer_state' do
    let(:raw) { { payer: { state: 'SP' } } }
    it do
      expect(subject.payer_state).to eq('SP')
    end
  end

  describe '#payer_zip_code' do
    let(:raw) { { payer: { zip_code: '13.897-12' } } }
    it do
      expect(subject.payer_zip_code).to eq('1389712')
    end
  end

  describe '#due_date' do
    let(:raw) { { boleto: { due_date: Date.new(2018, 9, 3) } } }
    it do
      expect(subject.due_date).to eq('03092018')
    end
  end

  describe '#issue_date' do
    context 'date given' do
      let(:raw) { { boleto: { issue_date: Date.new(2018, 2, 15) } } }
      it do
        expect(subject.issue_date).to eq("15022018")
      end
    end

    context 'date not given' do
      let(:raw) { { boleto: {} } }
      before { Timecop.freeze("2017-12-10") }
      after { Timecop.return }

      it do
        expect(subject.issue_date).to eq("10122017")
      end
    end
  end

  describe '#value' do
    let(:raw) { { boleto: { value: 1080.56 } } }
    it do
      expect(subject.value).to eq("108056")
    end
  end

  describe '#penalty_percentage' do
    context 'value given' do
      let(:raw) { { boleto: { penalty_percentage: 80.58 } } }
      it do
        expect(subject.penalty_percentage).to eq("8058")
      end
    end

    context 'value not given' do
      let(:raw) { { boleto: {} } }
      it do
        expect(subject.penalty_percentage).to eq("00")
      end
    end

  end

  describe '#penalty_days' do
    let(:raw) { { boleto: { penalty_days: "50" } } }
    it do
      expect(subject.penalty_days).to eq("50")
    end
  end

  describe '#interest_percentage' do
    context 'value given' do
      let(:raw) { { boleto: { interest_percentage: 25 } } }
      it do
        expect(subject.interest_percentage).to eq("2500")
      end
    end

    context 'value not given' do
      let(:raw) { { boleto: {} } }
      it do
        expect(subject.interest_percentage).to eq("00")
      end
    end
  end

  describe '#full_nosso_numero' do
    let(:raw) { { boleto: { nosso_numero: 1234567891 } } }
    it do
      expect(subject.full_nosso_numero).to eq("12345678919")
    end
  end

  describe '#message' do
    let(:raw) { { message: 'message' } }
    it do
      expect(subject.message).to eq("message")
    end
  end
end
