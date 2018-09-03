require "boletoman/itau_config"
require "boletoman/santander_config"

module Boletoman
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :env, :redis, :itau, :santander

    def initialize
      @env = :dev
    end

    def production_env?
      env == :production
    end
  end
end
