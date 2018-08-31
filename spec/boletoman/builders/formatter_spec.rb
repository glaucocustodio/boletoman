RSpec.describe Boletoman::Builders::Formatter do
  subject { described_class.new(raw) }
  let(:raw) { double(:raw) }

  describe '#transferor_name' do
    let(:raw) { { transferor: { name: 'Foo' } } }
    it do
      expect(subject.transferor_name).to eq('Foo')
    end
  end

  describe '#transferor_document' do
    let(:raw) { { transferor: { document: '123' } } }
    it do
      expect(subject.transferor_document).to eq('123')
    end
  end

  describe '#covenant' do
    let(:raw) { { transferor: { covenant: 'covenant' } } }

    it do
      expect(subject.covenant).to eq('covenant')
    end
  end

  describe '#branch' do
    let(:raw) { { transferor: { branch: 'branch' } } }

    it do
      expect(subject.branch).to eq('branch')
    end
  end

  describe '#checking_account' do
    let(:raw) { { transferor: { checking_account: 'checking_account' } } }

    it do
      expect(subject.checking_account).to eq('checking_account')
    end
  end

  describe '#wallet' do
    let(:raw) { { transferor: { wallet: 'wallet' } } }

    it do
      expect(subject.wallet).to eq('wallet')
    end
  end

  describe '#issue_date' do
    context 'date not given' do
      let(:raw) { { boleto: {} } }
      it do
        expect(Date).to receive(:today).and_return(Date.new(2018, 4, 20))
        expect(subject.issue_date).to eq(Date.new(2018, 4, 20))
      end
    end

    context 'date given' do
      let(:raw) { { boleto: { issue_date: Date.new(2019, 3, 20) } } }
      it do
        expect(subject.issue_date).to eq(Date.new(2019, 3, 20))
      end
    end
  end

  describe '#payer_name' do
    let(:raw) { { payer: { name: 'josé' } } }
    it do
      expect(subject.payer_name).to eq('josé')
    end
  end

  describe '#payer_document' do
    let(:raw) { { payer: { document: '57988722034' } } }
    it do
      expect(subject.payer_document).to eq('57988722034')
    end
  end

  describe '#payer_address' do
    let(:raw) do
      { payer: { street: "Rua", number: '1', neighborhood: "Bairro", city: "Itu", state: "SP", zip_code: "12" } }
    end
    it do
      expect(subject.payer_address).to eq(%(
        Rua, 1,
        Bairro - Itu / SP - 12
      ).squish)
    end
  end

  describe '#value' do
    let(:raw) { { boleto: { value: 200.5 } } }
    it do
      expect(subject.value).to eq("200.50")
    end
  end

  describe '#due_date' do
    let(:raw) { { boleto: { due_date: Date.new(2018, 4, 20) } } }
    it do
      expect(subject.due_date).to eq(Date.new(2018, 4, 20))
    end
  end

  describe '#instruction1' do
    let(:raw) { { boleto: { instruction1: "whatever" } } }

    it do
      expect(subject.instruction1).to eq("whatever")
    end
  end

  describe '#instruction2' do
    let(:raw) { { boleto: { instruction2: "whatever" } } }

    it do
      expect(subject.instruction2).to eq("whatever")
    end
  end

  describe '#instruction3' do
    let(:raw) { { boleto: { instruction3: "whatever" } } }

    it do
      expect(subject.instruction3).to eq("whatever")
    end
  end

  describe '#nosso_numero' do
    let(:raw) { { boleto: { nosso_numero: 'nosso_numero' } } }

    it do
      expect(subject.nosso_numero).to eq('nosso_numero')
    end
  end
end
