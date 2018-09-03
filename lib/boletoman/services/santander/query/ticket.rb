require_relative '../ticket'

module Boletoman
  module Services
    module Santander
      module Query
        class Ticket < Services::Santander::Ticket
          def message
            {
              'TicketRequest' => {
                dados: {
                  entry: [
                    {
                      key: 'CONVENIO.COD-BANCO',
                      value: BANK_CODE
                    },
                    {
                      key: 'CONVENIO.COD-CONVENIO',
                      value: ::Boletoman.configuration.santander.configuration.covenant
                    }
                  ]
                },
                expiracao: '100',
                sistema: 'YMB'
              }
            }
          end
        end
      end
    end
  end
end
