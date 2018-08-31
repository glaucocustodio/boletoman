RSpec.describe Boletoman::Services::Itau::Boleto::Request do
  subject { described_class.new(data) }
  let(:data) { double(:data) }
  let(:cache) { double(:cache) }
  let(:formatter) { double(:formatter) }
  let(:formatted_data) { 'formatted_data' }

  describe '#call', webmock: true do
    before do
      expect(Boletoman::Services::Itau::Token::Cache).to receive(:new).and_return(cache)
      expect(cache).to receive(:fetch).and_return('token')

      expect(Boletoman::Services::Itau::Boleto::Formatter).to(
        receive(:new).with(data).and_return(formatter)
      )
      expect(formatter).to receive(:format).and_return(formatted_data)

      allow(Boletoman).to(
        receive_message_chain('configuration.itau.configuration.key').and_return('key')
      )
      allow(Boletoman).to(
        receive_message_chain('configuration.itau.configuration.identificator').and_return('id')
      )
      stub_request(
        :post,
        "https://gerador-boletos.itau.com.br/router-gateway-app/public/codigo_barras/registro"
      ).with(
        body: formatted_data,
        headers: {
          'Accept' => 'application/vnd.itau',
          'Content-Type' => 'application/json',
          'access_token' => 'token',
          'itau-chave' => 'key',
          'identificador' => 'id'
        }
      )

      expect(Boletoman::Services::Itau::Boleto::Response).to(
        receive(:new).and_return(response)
      )
    end

    context 'response has error' do
      let(:response) { double(:response, error?: true, body: {}) }

      it do
        expect { subject.call }.to raise_error(/Falha ao gerar dados do boleto/)
      end
    end

    context 'response has not error' do
      let(:response) { double(:response, error?: false) }

      it do
        expect(subject.call).to eq(response)
      end
    end
  end
end
