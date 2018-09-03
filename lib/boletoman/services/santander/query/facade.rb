require_relative 'ticket'
require_relative 'query'

module Boletoman
  module Services
    module Santander
      module Query
        class Facade
          attr_reader :nsu

          def initialize(nsu)
            @nsu = nsu
          end

          def call
            { barcode: query_response.barcode, line: query_response.line }
          end

          private

          def ticket_response
            @ticket_response ||= Ticket.new.call
          end

          def query_response
            @query_response ||= Query.new(ticket: ticket_response.ticket, nsu: nsu).call
          end
        end
      end
    end
  end
end
