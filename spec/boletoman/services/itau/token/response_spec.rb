RSpec.describe Boletoman::Services::Itau::Token::Response do
  subject { described_class.new(raw) }
  let(:raw) { double(:raw, body: { access_token: 'abc123', expires_in: 2000 }.to_json) }

  describe '#token' do
    it do
      expect(subject.token).to eq('abc123')
    end
  end

  describe '#expires_in' do
    it do
      expect(subject.expires_in).to eq(1997)
    end
  end
end
