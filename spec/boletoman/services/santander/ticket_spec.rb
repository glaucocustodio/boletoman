RSpec.describe Boletoman::Services::Santander::Ticket do
  describe "#wsdl" do
    it do
      expect(Boletoman).to(
        receive_message_chain('configuration.santander.configuration.ticket_wsdl_url').and_return(
          'url'
        )
      )
      expect(subject.wsdl).to eq('url')
    end
  end

  describe "requires_certificate?" do
    it { expect(subject.requires_certificate?).to eq(false) }
  end

  describe "operation" do
    it { expect(subject.operation).to eq(:create) }
  end

  describe "response_class" do
    it { expect(subject.response_class).to eq(Boletoman::Services::Santander::TicketResponse) }
  end
end
