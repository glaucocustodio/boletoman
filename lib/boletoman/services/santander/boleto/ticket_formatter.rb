require 'active_support/all'

module Boletoman
  module Services
    module Santander
      module Boleto
        class TicketFormatter
          attr_reader :raw

          def initialize(raw)
            @raw = raw
          end

          def document_type
            raw[:payer][:document].strip.length == 11 ? "01" : "02"
          end

          def document
            raw[:payer][:document].remove(/\D/)
          end

          def payer_name
            raw[:payer][:name].first(40)
          end

          def payer_street
            raw[:payer][:street].first(40)
          end

          def payer_neighborhood
            raw[:payer][:neighborhood].first(30)
          end

          def payer_city
            raw[:payer][:city].first(20)
          end

          def payer_state
            raw[:payer][:state]
          end

          def payer_zip_code
            raw[:payer][:zip_code].remove(/\D/)
          end

          def due_date
            raw[:boleto][:due_date].strftime("%d%m%Y")
          end

          def issue_date
            (raw[:boleto][:issue_date] || Date.today).strftime("%d%m%Y")
          end

          def value
            raw[:boleto][:value].truncate(2).to_s.remove('.')
          end

          def full_nosso_numero
            nosso_numero = raw[:boleto][:nosso_numero]
            verificator_digit = nosso_numero.modulo11(
              multiplicador: (2..9).to_a, mapeamento: { 10 => 0, 11 => 0 }
            ) { |total| 11 - (total % 11) }

            "#{nosso_numero}#{verificator_digit}"
          end

          def message
            raw[:message]
          end
        end
      end
    end
  end
end
