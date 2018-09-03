require_relative 'request'

module Boletoman
  module Services
    module Itau
      module Token
        class Cache
          KEY = 'boletoman-itau-token'.freeze

          def fetch
            if redis
              get || set
            else
              request.token
            end
          end

          private

          def get
            redis.get(KEY)
          end

          def set
            redis.set(KEY, request.token, ex: request.expires_in)
            request.token
          end

          def request
            @request ||= Request.new.call
          end

          def redis
            @redis ||= ::Boletoman.configuration.redis
          end
        end
      end
    end
  end
end
