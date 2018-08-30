require_relative '../token/cache'
require_relative 'formatter'
require_relative 'response'

require "faraday"

module Boletoman
  module Services
    module Itau
      module Boleto
        class Request
          attr_reader :data

          def initialize(data)
            @data = data
          end

          def call
            Response.new(request).tap do |response|
              raise "Falha ao gerar dados do boleto #{response.body}" if response.error?
            end
          end

          private

          def request
            Faraday.new(url: url, headers: headers).send(:post) do |request|
              request.body = body
            end
          end

          def url
            'https://gerador-boletos.itau.com.br/router-gateway-app/public/codigo_barras/registro'
          end

          def body
            Formatter.new(data).format
          end

          def headers
            {
              'Accept' => 'application/vnd.itau',
              'Content-Type' => 'application/json',
              'access_token' => token,
              'itau-chave' => ::Boletoman.configuration.itau.configuration.key,
              'identificador' => ::Boletoman.configuration.itau.configuration.identificator
            }
          end

          def token
            Boletoman::Services::Itau::Token::Cache.new.fetch
          end
        end
      end
    end
  end
end
