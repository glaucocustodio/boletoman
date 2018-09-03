require 'boletoman/services/santander/boleto/facade'
require_relative 'base'

module Boletoman
  module Builders
    class Santander < Base
      def instance
        @instance ||= Bbrcobranca::Boleto::Santander.new(
          carteira: formatter.wallet,
          convenio: formatter.covenant,
          agencia: formatter.branch,
          conta_corrente: formatter.checking_account,
          cedente: formatter.transferor_name,
          documento_cedente: formatter.transferor_document,
          data_documento: formatter.issue_date,
          data_processamento: formatter.issue_date,
          sacado: formatter.payer_name,
          sacado_documento: formatter.payer_document,
          sacado_endereco: formatter.payer_address,
          valor: formatter.value,
          data_vencimento: formatter.due_date,
          aceite: formatter.acceptance,
          codigo_barras: barcode,
          nosso_numero: nosso_numero,
          instrucao1: formatter.instruction1,
          instrucao2: formatter.instruction2,
          instrucao3: formatter.instruction3
        )
      end

      private

      def barcode
        duplicate? ? data[:boleto][:barcode] : remote_response[:barcode]
      end

      def nosso_numero
        duplicate? ? data[:boleto][:nosso_numero] : remote_response[:nosso_numero]
      end

      def remote_response
        @remote_response ||= ::Boletoman::Services::Santander::Boleto::Facade.new(data).call
      end
    end
  end
end
