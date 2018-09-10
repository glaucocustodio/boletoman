require "bbrcobranca"
require_relative "formatter"

module Boletoman
  module Builders
    class Base
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def build
        ::Boletoman::Boleto.new(instance)
      end

      def instance
        raise NotImplementedError
      end

      def self.generator
        to_s.demodulize.downcase
      end

      def formatter
        @formatter ||= Formatter.new(data)
      end

      # segunda via
      def duplicate?
        data.dig(:boleto, :duplicate) == true
      end
    end
  end
end
