module Boletoman
  class ItauConfiguration
    attr_accessor :token, :key, :identificator, :client_id, :client_secret
  end

  class Itau
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= ItauConfiguration.new
      yield(configuration)
      self
    end
  end
end
