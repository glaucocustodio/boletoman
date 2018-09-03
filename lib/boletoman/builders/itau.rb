require 'boletoman/services/itau/boleto/request'
require_relative 'base'

module Boletoman
  module Builders
    class Itau < Base
      def instance
        @instance ||= ::Bbrcobranca::Boleto::Itau.new(
          carteira: formatter.wallet,
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
        boleto_data.barcode
      end

      def nosso_numero
        boleto_data.nosso_numero
      end

      def boleto_data
        @boleto_data ||= ::Boletoman::Services::Itau::Boleto::Request.new(data).call
      end
    end
  end
end
