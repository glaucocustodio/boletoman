RSpec.describe Boletoman::Services::Itau::Token::Cache do
  describe '#fetch' do
    let(:request) { double(:request) }
    let(:response) { double(:response, token: 'token', expires_in: 1000) }

    before do
      expect(Boletoman).to receive_message_chain('configuration.redis').and_return($redis)
    end

    context 'cache does not exist' do
      it do
        $redis.del(described_class::KEY)

        expect(Boletoman::Services::Itau::Token::Request).to receive(:new).once.and_return(request)
        expect(request).to receive(:call).once.and_return(response)

        expect(subject.fetch).to eq('token')
        expect($redis.ttl(described_class::KEY)).to eq(1000)
      end
    end

    context 'cache exists' do
      it do
        $redis.set(described_class::KEY, 'foo')
        expect(subject.fetch).to eq('foo')
      end
    end
  end
end
