require_relative '../billing'

module Boletoman
  module Services
    module Santander
      module Query
        class Query < Services::Santander::Billing
          def operation
            :consulta_titulo
          end
        end
      end
    end
  end
end
