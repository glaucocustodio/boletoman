module Boletoman
  module Services
    module Itau
      module Boleto
        class Response
          attr_reader :status, :body

          def initialize(raw)
            @status = raw.status
            @body = JSON.parse(raw.body)
          end

          def error?
            status >= 400
          end

          def barcode
            body['codigo_barras']
          end

          def line
            body['numero_linha_digitavel']
          end

          def nosso_numero
            body['nosso_numero'][0..-2] # remove the verificator digit
          end
        end
      end
    end
  end
end
