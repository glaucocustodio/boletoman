module Boletoman
  module Services
    module Itau
      module Boleto
        class Formatter
          attr_reader :data

          def initialize(data)
            @data = data
          end

          def format
            {
              tipo_ambiente: env,
              tipo_registro: record_type,
              tipo_cobranca: billing_type,
              tipo_produto: '00006',
              subproduto: '00008',
              beneficiario: {
                cpf_cnpj_beneficiario: transferor_document,
                agencia_beneficiario: transferor_branch,
                conta_beneficiario: transferor_account,
                digito_verificador_conta_beneficiario: transferor_account_digit
              },
              titulo_aceite: 'N',
              pagador: {
                cpf_cnpj_pagador: payer_document,
                nome_pagador: payer_name,
                logradouro_pagador: payer_street,
                cidade_pagador: payer_city,
                uf_pagador: payer_state,
                cep_pagador: payer_zip_code
              },
              tipo_carteira_titulo: wallet,
              moeda: { codigo_moeda_cnab: '09' },
              nosso_numero: nosso_numero,
              digito_verificador_nosso_numero: nosso_numero_digit,
              data_vencimento: due_date,
              valor_cobrado: value,
              especie: '01',
              data_emissao: issue_date,
              tipo_pagamento: 1,
              indicador_pagamento_parcial: 'false',
              juros: { tipo_juros: 5 },
              multa: { tipo_multa: 3 },
              grupo_desconto: [{ tipo_desconto: '0' }],
              recebimento_divergente: { tipo_autorizacao_recebimento: '1' }
            }.to_json
          end

          private

          def env
            ::Boletoman.configuration.production_env? ? 2 : 1
          end

          def record_type
            { 'registro' => 1, 'alteracao' => 2, 'consulta' => 3 }['registro']
          end

          def billing_type
            {
              'boleto' => 1,
              'debito automático' => 2,
              'cartão de crédito' => 3,
              'TEF reversa' => 4
            }['boleto']
          end

          def transferor_document
            data[:transferor][:document].remove(%r{[.\/-]})
          end

          def transferor_branch
            data[:transferor][:branch].rjust(4, '0')
          end

          def transferor_account
            data[:transferor][:checking_account][0..-2].rjust(7, '0')
          end

          def transferor_account_digit
            data[:transferor][:checking_account].last
          end

          def wallet
            data[:transferor][:wallet]
          end

          def payer_document
            data[:payer][:document].remove(/[.-]/).rjust(11, '0')
          end

          def payer_name
            data[:payer][:name].strip.first(30)
          end

          def payer_street
            data[:payer][:street]
          end

          def payer_city
            data[:payer][:city]
          end

          def payer_state
            data[:payer][:state]
          end

          def payer_zip_code
            data[:payer][:zip_code].remove(/[.-]/)
          end

          def due_date
            data[:boleto][:due_date].to_s
          end

          def nosso_numero
            data[:boleto][:nosso_numero].rjust(8, '0')
          end

          def nosso_numero_digit
            "#{transferor_branch}#{transferor_account}#{wallet}#{nosso_numero}".modulo10
          end

          def value
            (data[:boleto][:value].round(2) * 100).truncate.to_s.rjust(16, '0')
          end

          def issue_date
            Date.today.to_s
          end
        end
      end
    end
  end
end
