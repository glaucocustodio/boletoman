require 'boletoman/services/soap/response'

module Boletoman
  module Services
    module Santander
      class BillingResponse < Soap::Response
        def success?
          barcode.present?
        end

        def barcode
          body.dig(:return, :titulo, :cd_barra)
        end

        def line
          body.dig(:return, :titulo, :lin_dig)
        end

        def nosso_numero
          body.dig(:return, :titulo, :nosso_numero)
        end
      end
    end
  end
end
