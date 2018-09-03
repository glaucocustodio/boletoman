require_relative 'ticket'
require_relative 'boleto'

module Boletoman
  module Services
    module Santander
      module Boleto
        class Facade
          attr_reader :data

          def initialize(data)
            @data = data
          end

          def call
            {
              barcode: boleto_response.barcode,
              line: boleto_response.line,
              nosso_numero: boleto_response.nosso_numero,
              nsu: nsu,
              ticket: ticket_response.ticket
            }
          end

          private

          def boleto_response
            ap nsu
            @boleto_response ||= Boleto.new(
              ticket: ticket_response.ticket, nsu: nsu, nsu_date: data[:boleto][:issue_date]
            ).call
          end

          def nsu
            @nsu ||= data[:boleto][:nsu] || SecureRandom.hex(3)
          end

          def ticket_response
            @ticket_response ||= Ticket.new(data).call
          end
        end
      end
    end
  end
end
