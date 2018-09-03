RSpec.describe Boletoman::Services::Santander::Boleto::Ticket do
  subject { described_class.new(data) }
  let(:data) { double(:data) }

  describe "#message" do
    let(:formatted_data) do
      double(
        document_type: "01",
        document: "33999236787",
        payer_name: "PEDRO DE ALCÂNTARA FRANCISCO ANTÔNIO",
        payer_street: "Rua Comendador João do nome",
        payer_neighborhood: "Conjunto habitacional",
        payer_city: "Cidade de São José",
        payer_state: "SP",
        payer_zip_code: "13174580",
        full_nosso_numero: "12345678919",
        due_date: "20022018",
        issue_date: "15022018",
        value: "20047",
        message: "sou uma msg"
      )
    end

    it do
      stub_const("Boletoman::Services::Santander::Ticket::BANK_CODE", "bank_code")
      expect(Boletoman).to(
        receive_message_chain(
          'configuration.santander.configuration.covenant'
        ).and_return('covenant')
      )
      expect(Boletoman::Services::Santander::Boleto::TicketFormatter).to(
        receive(:new).once.with(data).and_return(formatted_data)
      )

      expect(subject.message).to eq(
        'TicketRequest' => {
          dados: {
            entry: [
              {
                key: 'CONVENIO.COD-BANCO',
                value: "bank_code"
              },
              {
                key: 'CONVENIO.COD-CONVENIO',
                value: "covenant"
              },
              {
                key: 'PAGADOR.TP-DOC',
                value: "01"
              },
              {
                key: 'PAGADOR.NUM-DOC',
                value: "33999236787"
              },
              {
                key: 'PAGADOR.NOME',
                value: "PEDRO DE ALCÂNTARA FRANCISCO ANTÔNIO"
              },
              {
                key: 'PAGADOR.ENDER',
                value: "Rua Comendador João do nome"
              },
              {
                key: 'PAGADOR.BAIRRO',
                value: "Conjunto habitacional"
              },
              {
                key: 'PAGADOR.CIDADE',
                value: "Cidade de São José"
              },
              {
                key: 'PAGADOR.UF',
                value: "SP"
              },
              {
                key: 'PAGADOR.CEP',
                value: "13174580"
              },
              {
                key: 'TITULO.SEU-NUMERO',
                value: '12345678919'
              },
              {
                key: 'TITULO.NOSSO-NUMERO',
                value: '12345678919'
              },
              {
                key: 'TITULO.DT-VENCTO',
                value: "20022018"
              },
              {
                key: 'TITULO.DT-EMISSAO',
                value: "15022018"
              },
              {
                key: 'TITULO.ESPECIE',
                value: 17
              },
              {
                key: 'TITULO.VL-NOMINAL',
                value: "20047"
              },
              {
                key: 'TITULO.PC-MULTA',
                value: '200'
              },
              {
                key: 'TITULO.QT-DIAS-MULTA',
                value: '01'
              },
              {
                key: 'TITULO.PC-JURO',
                value: '100'
              },
              {
                key: 'TITULO.TP-PROTESTO',
                value: 0
              },
              {
                key: 'MENSAGEM',
                value: "sou uma msg"
              }
            ]
          },
          expiracao: '100',
          sistema: 'YMB'
        }
      )
    end
  end
end
