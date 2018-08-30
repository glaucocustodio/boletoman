require_relative 'formatter'

module Boletoman
  module Builders
    class ItauFormatter < Formatter
      def checking_account
        raw[:transferor][:checking_account][0..-2]
      end
    end
  end
end
