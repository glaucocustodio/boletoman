module Boletoman
  module Services
    module Itau
      module Token
        class Response
          attr_reader :raw

          def initialize(raw)
            @raw = JSON.parse(raw)
          end

          def token
            raw["access_token"]
          end

          def expires_in
            raw["expires_in"] - 3
          end
        end
      end
    end
  end
end
