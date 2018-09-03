require_relative '../ticket'
require_relative 'ticket_formatter'

module Boletoman
  module Services
    module Santander
      module Boleto
        class Ticket < Services::Santander::Ticket
          attr_reader :data

          def initialize(data)
            @data = data
          end

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
                      value: covenant
                    },
                    {
                      key: 'PAGADOR.TP-DOC',
                      value: formatter.document_type
                    },
                    {
                      key: 'PAGADOR.NUM-DOC',
                      value: formatter.document
                    },
                    {
                      key: 'PAGADOR.NOME',
                      value: formatter.payer_name
                    },
                    {
                      key: 'PAGADOR.ENDER',
                      value: formatter.payer_street
                    },
                    {
                      key: 'PAGADOR.BAIRRO',
                      value: formatter.payer_neighborhood
                    },
                    {
                      key: 'PAGADOR.CIDADE',
                      value: formatter.payer_city
                    },
                    {
                      key: 'PAGADOR.UF',
                      value: formatter.payer_state
                    },
                    {
                      key: 'PAGADOR.CEP',
                      value: formatter.payer_zip_code
                    },
                    {
                      key: 'TITULO.SEU-NUMERO',
                      value: formatter.full_nosso_numero
                    },
                    {
                      key: 'TITULO.NOSSO-NUMERO',
                      value: formatter.full_nosso_numero
                    },
                    {
                      key: 'TITULO.DT-VENCTO',
                      value: formatter.due_date
                    },
                    {
                      key: 'TITULO.DT-EMISSAO',
                      value: formatter.issue_date
                    },
                    {
                      key: 'TITULO.ESPECIE',
                      value: 17
                    },
                    {
                      key: 'TITULO.VL-NOMINAL',
                      value: formatter.value
                    },
                    {
                      key: 'TITULO.PC-MULTA',
                      value: formatter.penalty_percentage
                    },
                    {
                      key: 'TITULO.QT-DIAS-MULTA',
                      value: formatter.penalty_days
                    },
                    {
                      key: 'TITULO.PC-JURO',
                      value: formatter.interest_percentage
                    },
                    {
                      key: 'MENSAGEM',
                      value: formatter.message
                    }
                  ]
                },
                expiracao: '100',
                sistema: 'YMB'
              }
            }
          end

          private

          def formatter
            @formatter ||= TicketFormatter.new(data)
          end

          def covenant
            ::Boletoman.configuration.santander.configuration.covenant
          end
        end
      end
    end
  end
end
