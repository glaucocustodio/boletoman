RSpec.describe Boletoman::Services::Santander::Query::Ticket do
  describe '#message' do
    it do
      stub_const("Boletoman::Services::Santander::Ticket::BANK_CODE", "bank_code")
      expect(Boletoman).to(
        receive_message_chain(
          'configuration.santander.configuration.covenant'
        ).and_return('covenant')
      )

      expect(subject.message).to eq(
        'TicketRequest' => {
          dados: {
            entry: [
              {
                key: 'CONVENIO.COD-BANCO',
                value:'bank_code'
              },
              {
                key: 'CONVENIO.COD-CONVENIO',
                value: 'covenant'
              }
            ]
          },
          expiracao: '100',
          sistema: 'YMB'
        }
      )
    end
  end
end
