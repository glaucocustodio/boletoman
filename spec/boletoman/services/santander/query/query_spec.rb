RSpec.describe Boletoman::Services::Santander::Query::Query do
  describe '#operation' do
    it do
      expect(subject.operation).to eq(:consulta_titulo)
    end
  end
end
