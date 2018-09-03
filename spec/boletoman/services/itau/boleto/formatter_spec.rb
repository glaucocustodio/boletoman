RSpec.describe Boletoman::Services::Itau::Boleto::Formatter do
  subject { described_class.new(data) }

  describe '#format' do
    let(:data) do
      {
        transferor: {
          document: '23.371.251/0001-88',
          checking_account: '119097',
          wallet: '109',
          branch: '36'
        },
        payer: {
          document: '038.946.130-09',
          name: '         Jose Silvaaabbbccccdddeeffgghhhuuujjkkklllmmmnnooppp  ',
          street: 'Travessa Agenor Matos',
          city: 'Salvador',
          state: 'BA',
          zip_code: '41.207-830'
        },
        boleto: {
          nosso_numero: '4',
          due_date: Date.new(2018, 7, 27),
          value: 180.51,
          acceptance: 'S'
        }
      }
    end

    it do
      expect(Boletoman).to receive_message_chain('configuration.production_env?').and_return(false)
      expect(subject.format).to eq(
        {
          tipo_ambiente: 1,
          tipo_registro: 1,
          tipo_cobranca: 1,
          tipo_produto: '00006',
          subproduto: '00008',
          beneficiario: {
            cpf_cnpj_beneficiario: '23371251000188',
            agencia_beneficiario: '0036',
            conta_beneficiario: '0011909',
            digito_verificador_conta_beneficiario: '7'
          },
          titulo_aceite: 'S',
          pagador: {
            cpf_cnpj_pagador: '03894613009',
            nome_pagador: "Jose Silvaaabbbccccdddeeffgghh",
            logradouro_pagador: 'Travessa Agenor Matos',
            cidade_pagador: 'Salvador',
            uf_pagador: 'BA',
            cep_pagador: '41207830'
          },
          tipo_carteira_titulo: '109',
          moeda: { codigo_moeda_cnab: '09' },
          nosso_numero: '00000004',
          digito_verificador_nosso_numero: 4,
          data_vencimento: '2018-07-27',
          valor_cobrado: '0000000000018051',
          especie: '01',
          data_emissao: Date.today.to_s,
          tipo_pagamento: 1,
          indicador_pagamento_parcial: 'false',
          juros: { tipo_juros: 5 },
          multa: { tipo_multa: 3 },
          grupo_desconto: [{ tipo_desconto: '0' }],
          recebimento_divergente: { tipo_autorizacao_recebimento: '1' }
        }.to_json
      )
    end
  end
end
