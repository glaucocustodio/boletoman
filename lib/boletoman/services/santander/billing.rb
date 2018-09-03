require_relative 'request'
require_relative 'billing_response'

module Boletoman
  module Services
    module Santander
      class Billing < Request
        attr_reader :ticket
        attr_writer :nsu, :nsu_date

        def initialize(**args)
          @ticket = args[:ticket]
          @nsu = args[:nsu]
          @nsu_date = args[:nsu_date]
        end

        def wsdl
          "https://ymbcash.santander.com.br/ymbsrv/CobrancaEndpointService/CobrancaEndpointService.wsdl".freeze
        end

        def requires_certificate?
          ::Boletoman.configuration.santander.configuration.use_certificate
        end

        def message
          {
            dto: {
              dtNsu: nsu_date,
              estacao: station,
              nsu: nsu,
              ticket: ticket,
              tpAmbiente: env
            }
          }
        end

        def response_class
          ::Boletoman::Services::Santander::BillingResponse
        end

        private

        def env
          production? ? 'P' : 'T'
        end

        def nsu_date
          (@nsu_date || Date.today).strftime("%d%m%Y")
        end

        def nsu
          prefix = production? ? nil : 'TST'
          "#{prefix}#{@nsu}"
        end

        def production?
          ::Boletoman.configuration.production_env?
        end

        def station
          ::Boletoman.configuration.santander.configuration.station
        end
      end
    end
  end
end
