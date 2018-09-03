RSpec.describe Boletoman::Services::Santander::Query::Facade do
  subject { described_class.new('nsu') }

  describe '#call' do
    let(:ticket) { double(:ticket) }
    let(:ticket_response) { double(:ticket_response, ticket: 'ticket') }
    let(:query) { double(:query) }
    let(:query_response) { double(:query_response, barcode: 'barcode', line: 'line') }

    it do
      expect(Boletoman::Services::Santander::Query::Ticket).to receive(:new).and_return(ticket)
      expect(ticket).to receive(:call).and_return(ticket_response)

      expect(Boletoman::Services::Santander::Query::Query).to(
        receive(:new).with(ticket: 'ticket', nsu: 'nsu').and_return(query)
      )
      expect(query).to receive(:call).and_return(query_response)

      expect(subject.call).to eq(barcode: 'barcode', line: 'line')
    end
  end
end
