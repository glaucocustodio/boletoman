module Boletoman
  module Services
    module Soap
      class Response
        attr_reader :raw_response, :requester

        def initialize(raw_response, requester)
          @raw_response = raw_response
          @requester = requester
        end

        def body
          raw_response.body["#{requester.operation}_response".to_sym]
        end
      end
    end
  end
end
