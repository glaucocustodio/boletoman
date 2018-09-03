module Boletoman
  class SantanderConfiguration
    attr_accessor :covenant, :station, :certificate, :certificate_key, :use_certificate,
      :ticket_wsdl_url

    def initialize()
      @ticket_wsdl_url = 'https://ymbdlb.santander.com.br/dl-ticket-services/TicketEndpointService/TicketEndpointService.wsdl'
      @use_certificate = true
    end
  end

  class Santander
    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= SantanderConfiguration.new
      yield(configuration)
      self
    end
  end
end
