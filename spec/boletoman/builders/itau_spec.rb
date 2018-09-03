RSpec.describe Boletoman::Builders::Itau do
  subject { described_class.new(data) }
  let(:data) { double(:data) }

  describe '#instance' do
    let(:formatter) do
      double(
        :formatter,
        wallet: 'wallet',
        branch: 'branch',
        checking_account: 'checking_account',
        transferor_name: 'transferor_name',
        transferor_document: 'transferor_document',
        issue_date: 'issue_date',
        payer_name: 'payer_name',
        payer_document: 'payer_document',
        payer_address: 'payer_address',
        value: 'value',
        due_date: 'due_date',
        instruction1: 'instruction1',
        instruction2: 'instruction2',
        instruction3: 'instruction3',
        acceptance: 'N'
      )
    end
    let(:request) { double(:request) }
    let(:boleto_data) do
      double(:boleto_data, barcode: 'barcode', nosso_numero: 'nosso_numero')
    end

    it do
      allow(subject).to receive(:formatter).and_return(formatter)
      expect(Boletoman::Services::Itau::Boleto::Request).to(
        receive(:new).with(data).and_return(request)
      )
      expect(request).to receive(:call).and_return(boleto_data)

      expect(Bbrcobranca::Boleto::Itau).to receive(:new).with(
        carteira: 'wallet',
        agencia: 'branch',
        conta_corrente: 'checking_account',
        cedente: 'transferor_name',
        documento_cedente: 'transferor_document',
        data_documento: 'issue_date',
        data_processamento: 'issue_date',
        sacado: 'payer_name',
        sacado_documento: 'payer_document',
        sacado_endereco: 'payer_address',
        valor: 'value',
        data_vencimento: 'due_date',
        aceite: 'N',
        codigo_barras: 'barcode',
        nosso_numero: 'nosso_numero',
        instrucao1: 'instruction1',
        instrucao2: 'instruction2',
        instrucao3: 'instruction3'
      ).and_return(:result)

      expect(subject.instance).to eq(:result)
    end
  end
end
