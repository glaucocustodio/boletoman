RSpec.describe Boletoman::Services::Santander::Boleto::Facade do
  let(:data) { { boleto: { nsu: 'nsu', issue_date: 'issue_date' }} }
  subject { described_class.new(data) }

  describe "#call" do
    let(:ticket) { double(:ticket) }
    let(:ticket_response) { double(:ticket_response, success?: true, ticket: 'ticket') }
    let(:boleto) { double(:boleto) }
    let(:boleto_response) do
      double(:boleto_response, barcode: 'barcode', line: 'line', nosso_numero: 'nosso_numero')
    end

    it do
      expect(Boletoman::Services::Santander::Boleto::Ticket).to(
        receive(:new).with(data).once.and_return(ticket)
      )
      expect(ticket).to receive(:call).once.and_return(ticket_response)

      expect(Boletoman::Services::Santander::Boleto::Boleto).to(
        receive(:new).with(ticket: 'ticket', nsu: 'nsu', nsu_date: 'issue_date').and_return(boleto)
      )
      expect(boleto).to receive(:call).and_return(boleto_response)

      expect(subject.call).to eq(
        barcode: 'barcode',
        line: 'line',
        nosso_numero: 'nosso_numero',
        nsu: 'nsu',
        ticket: 'ticket'
      )
    end
  end
end
