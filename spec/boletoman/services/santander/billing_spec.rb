RSpec.describe Boletoman::Services::Santander::Billing do
  subject { described_class.new(ticket: "ticket", nsu: "123", nsu_date: Date.new(2018, 4, 11)) }

  describe "#wsdl" do
    it do
      expect(subject.wsdl).to eq(
        "https://ymbcash.santander.com.br/ymbsrv/CobrancaEndpointService/CobrancaEndpointService.wsdl"
      )
    end
  end

  describe "#requires_certificate?" do
    it do
      expect(Boletoman).to(
        receive_message_chain(
          'configuration.santander.configuration.use_certificate'
        ).and_return(false)
      )
      expect(subject.requires_certificate?).to eq(false)
    end
  end

  describe "#message" do
    it do
      allow(Boletoman).to receive_message_chain('configuration.production_env?').and_return(false)
      expect(Boletoman).to(
        receive_message_chain('configuration.santander.configuration.station').and_return('station')
      )

      expect(subject.message).to eq(
        dto: {
          dtNsu: '11042018',
          estacao: 'station',
          nsu: 'TST123',
          ticket: 'ticket',
          tpAmbiente: 'T'
        }
      )
    end
  end

  describe "#response_class" do
    it { expect(subject.response_class).to eq(Boletoman::Services::Santander::BillingResponse) }
  end
end
