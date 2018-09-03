RSpec.describe Boletoman::Services::Soap::Response do
  subject { described_class.new(raw_response, requester) }

  describe "#body" do
    let(:raw_response) { double(:raw_response, body: { create_response: "whatever" }) }
    let(:requester) { double(:requester, operation: :create) }
    it do
      expect(subject.body).to eq("whatever")
    end
  end
end
