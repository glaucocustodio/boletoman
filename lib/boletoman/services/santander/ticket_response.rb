require 'boletoman/services/soap/response'

module Boletoman
  module Services
    module Santander
      class TicketResponse < Soap::Response
        def success?
          body[:ticket_response][:ret_code] == "0"
        end

        def ticket
          body[:ticket_response][:ticket]
        end
      end
    end
  end
end
