require 'boletoman/services/soap/request'

module Boletoman
  module Services
    module Santander
      class Request < Soap::Request
        def extra_config_options
          certificate_config
        end

        def requires_certificate?
          raise NotImplementedError
        end

        private

        def certificate_config
          return {} unless requires_certificate?
          {
            ssl_cert_file: certificate,
            ssl_cert_key_file: certificate_key
          }
        end

        def certificate
          path = ::Boletoman.configuration.santander.configuration.certificate
          raise "Arquivo do certificado não existe" unless File.exist?(path)
          File.expand_path(path)
        end

        def certificate_key
          path = ::Boletoman.configuration.santander.configuration.certificate_key
          raise "Arquivo chave do certificado não existe" unless File.exist?(path)
          File.expand_path(path)
        end
      end
    end
  end
end
