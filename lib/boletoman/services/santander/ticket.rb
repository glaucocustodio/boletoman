require_relative 'request'
require_relative 'ticket_response'

module Boletoman
  module Services
    module Santander
      class Ticket < Request
        BANK_CODE = '0033'.freeze

        def wsdl
          ::Boletoman.configuration.santander.configuration.ticket_wsdl_url
        end

        def requires_certificate?
          false
        end

        def operation
          :create
        end

        def response_class
          ::Boletoman::Services::Santander::TicketResponse
        end
      end
    end
  end
end
