require 'savon'

module Boletoman
  module Services
    module Soap
      class Request
        def call
          response_class.new(response, self).tap do |response|
            raise "Falha ao chamar operação #{operation}: #{response.body}" unless response.success?
          end
        end

        def response_class
          "#{self.class}Response".constantize
        end

        def response
          client.call(operation, message: message)
        end

        def client
          @client ||= Savon.client(config_options)
        end

        def operation
          raise NotImplementedError
        end

        def message
          raise NotImplementedError
        end

        def config_options
          wsdl_config.merge(extra_config_options)
        end

        def wsdl_config
          { wsdl: wsdl }
        end

        def extra_config_options
          {}
        end

        def wsdl
          raise NotImplementedError
        end
      end
    end
  end
end
