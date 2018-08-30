module Boletoman
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :env, :redis, :itau

    def initialize
      @env = :dev
    end

    def production_env?
      env == :production
    end
  end

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
