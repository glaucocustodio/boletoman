RSpec.describe Boletoman::Services::Santander::Boleto::Boleto do
  describe "#operation" do
    it { expect(subject.operation).to eq(:registra_titulo) }
  end
end
