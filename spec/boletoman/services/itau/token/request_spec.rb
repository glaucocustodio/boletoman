RSpec.describe Boletoman::Services::Itau::Token::Request do
  describe '#call', webmock: true do
    let(:response) { double(:response) }

    before do
      allow(Boletoman).to(
        receive_message_chain('configuration.itau.configuration.client_id').and_return('id')
      )
      allow(Boletoman).to(
        receive_message_chain('configuration.itau.configuration.client_secret').and_return('secret')
      )
      stub_request(:post, url)
        .with(
          body: { scope: 'readonly', grant_type: 'client_credentials' },
          headers: { authorization: /Basic \w+/ }
        )
        .to_return(body: 'reponse_json')

      expect(Boletoman::Services::Itau::Token::Response).to(
        receive(:new).with(an_instance_of(Faraday::Response)).and_return(response)
      )
    end

    after do
      expect(subject.call).to eq(response)
    end

    context 'env is production' do
      let(:url) { 'https://autorizador-boletos.itau.com.br/' }

      it do
        expect(Boletoman).to receive_message_chain('configuration.production_env?').and_return(true)
      end
    end

    context 'env is not production' do
      let(:url) { 'https://oauth.itau.com.br/identity/connect/token' }

      it do
        expect(Boletoman).to(
          receive_message_chain('configuration.production_env?').and_return(false)
        )
      end
    end
  end
end
