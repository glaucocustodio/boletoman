require_relative 'response'

require "faraday"

module Boletoman
  module Services
    module Itau
      module Token
        class Request
          def call
            Response.new(request)
          end

          private

          def request
            ::Faraday.new(url: url, headers: headers).send(:post) do |request|
              request.body = params
            end
          end

          def url
            if ::Boletoman.configuration.production_env?
              'https://autorizador-boletos.itau.com.br/'
            else
              'https://oauth.itau.com.br/identity/connect/token'
            end
          end

          def params
            { scope: 'readonly', grant_type: 'client_credentials' }
          end

          def headers
            { authorization: "Basic #{credentials}" }
          end

          def credentials
            Base64.strict_encode64("#{client_id}:#{client_secret}")
          end

          def client_id
            ::Boletoman.configuration.itau.configuration.client_id
          end

          def client_secret
            ::Boletoman.configuration.itau.configuration.client_secret
          end
        end
      end
    end
  end
end
