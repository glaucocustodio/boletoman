RSpec.describe Boletoman::Builders::Santander do
  subject { described_class.new(data) }
  let(:data) { { boleto: {} } }

  describe '#instance' do
    let(:facade) { double(:facade) }
    let(:santander_response) { { barcode: 'barcode', nosso_numero: 'nosso_numero' } }
    let(:formatter) do
      double(
        :formatter,
        wallet: '892',
        covenant: '123',
        branch: '11',
        checking_account: '22',
        transferor_name: 'Adimplere',
        transferor_document: '9988',
        issue_date: Date.new(2018, 10, 20),
        payer_name: 'Maria',
        payer_document: '1234',
        payer_address: 'Rua x, Bairro y - Sumaré / SP - 123456',
        value: 200,
        due_date: Date.new(2018, 10, 30),
        acceptance: 'N',
        instruction1: 'santander instruction 1',
        instruction2: 'santander instruction 2',
        instruction3: 'santander instruction 3'
      )
    end

    it do
      expect(Boletoman::Services::Santander::Boleto::Facade).to(
        receive(:new).with(data).once.and_return(facade)
      )
      expect(facade).to receive(:call).once.and_return(santander_response)
      allow(subject).to receive(:formatter).and_return(formatter)
      expect(Bbrcobranca::Boleto::Santander).to receive(:new).with(
        carteira: "892",
        convenio: "123",
        agencia: "11",
        conta_corrente: "22",
        cedente: "Adimplere",
        documento_cedente: "9988",
        data_documento: Date.new(2018, 10, 20),
        data_processamento: Date.new(2018, 10, 20),
        sacado: 'Maria',
        sacado_documento: '1234',
        sacado_endereco: 'Rua x, Bairro y - Sumaré / SP - 123456',
        valor: 200,
        data_vencimento: Date.new(2018, 10, 30),
        aceite: 'N',
        codigo_barras: 'barcode',
        nosso_numero: 'nosso_numero',
        instrucao1: 'santander instruction 1',
        instrucao2: 'santander instruction 2',
        instrucao3: 'santander instruction 3'
      ).and_return(:brcobranca_instance)

      expect(subject.instance).to eq(:brcobranca_instance)
    end
  end
end
