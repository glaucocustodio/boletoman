require 'active_support/all'

module Boletoman
  module Builders
    class Formatter
      attr_accessor :raw

      def initialize(raw)
        @raw = raw
      end

      def transferor_name
        raw[:transferor][:name]
      end

      def transferor_document
        raw[:transferor][:document]
      end

      def covenant
        raw[:transferor][:covenant]
      end

      def branch
        raw[:transferor][:branch]
      end

      def checking_account
        raw[:transferor][:checking_account]
      end

      def wallet
        raw[:transferor][:wallet]
      end

      def issue_date
        raw.dig(:boleto, :issue_date) || Date.today
      end

      def payer_name
        raw[:payer][:name]
      end

      def payer_document
        raw[:payer][:document]
      end

      def payer_address
        full_address_for(raw[:payer])
      end

      def value
        format('%1.2f', raw_value)
      end

      def due_date
        raw[:boleto][:due_date]
      end

      def instruction1
        raw[:boleto][:instruction1]
      end

      def instruction2
        raw[:boleto][:instruction2]
      end

      def instruction3
        raw[:boleto][:instruction3]
      end

      def nosso_numero
        raw[:boleto][:nosso_numero]
      end

      private

      def full_address_for(payer)
        %(
          #{payer[:street]}, #{payer[:number]},
          #{payer[:neighborhood]} - #{payer[:city]} /
          #{payer[:state]} - #{payer[:zip_code]}
        ).squish
      end

      def raw_value
        raw[:boleto][:value]
      end
    end
  end
end
