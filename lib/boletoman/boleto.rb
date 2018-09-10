module Boletoman
  class Boleto
    attr_reader :pdf_generator_instance

    def initialize(pdf_generator_instance)
      @pdf_generator_instance = pdf_generator_instance
    end

    def line
      pdf_generator_instance.codigo_barras.linha_digitavel
    end

    def barcode
      pdf_generator_instance.codigo_barras
    end

    def nosso_numero
      pdf_generator_instance.nosso_numero_boleto
    end

    def pdf
      pdf_generator_instance.to_pdf
    end
  end
end
