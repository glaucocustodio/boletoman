require_relative '../billing'

module Boletoman
  module Services
    module Santander
      module Boleto
        class Boleto < Services::Santander::Billing
          def operation
            :registra_titulo
          end
        end
      end
    end
  end
end
