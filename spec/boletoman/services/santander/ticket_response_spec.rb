RSpec.describe Boletoman::Services::Santander::TicketResponse do
  let(:raw_response) { double(:raw_response) }
  let(:requester) { double(:requester) }
  subject { described_class.new(raw_response, requester) }

  describe "#success?" do
    context "true" do
      it do
        expect(subject).to receive(:body).and_return({ ticket_response: { ret_code: "0" } })
        expect(subject.success?).to eq(true)
      end
    end

    context "false" do
      it do
        expect(subject).to receive(:body).and_return({ ticket_response: { ret_code: "11" } })
        expect(subject.success?).to eq(false)
      end
    end
  end

  describe "#ticket" do
    it do
      expect(subject).to receive(:body).and_return(ticket_response: { ticket: "778899" })
      expect(subject.ticket).to eq("778899")
    end
  end
end
