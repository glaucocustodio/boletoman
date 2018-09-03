RSpec.describe Boletoman::Services::Santander::BillingResponse do
  let(:raw_response) { double(:raw_response) }
  let(:requester) { double(:requester) }
  subject { described_class.new(raw_response, requester) }

  describe "#success?" do
    context "true" do
      it do
        expect(subject).to receive(:barcode).and_return("12345")
        expect(subject.success?).to eq(true)
      end
    end

    context "false" do
      it do
        expect(subject).to receive(:barcode).and_return(nil)
        expect(subject.success?).to eq(false)
      end
    end
  end

  describe "#barcode" do
    context "is nil" do
      it do
        expect(subject).to receive(:body).and_return({ return: { titulo: { cd_barra: nil } } })
        expect(subject.barcode).to eq(nil)
      end
    end

    context "is not nil" do
      it do
        expect(subject).to receive(:body).and_return({ return: { titulo: { cd_barra: "123456" } } })
        expect(subject.barcode).to eq("123456")
      end
    end
  end

  describe "#line" do
    context "is nil" do
      it do
        expect(subject).to receive(:body).and_return({ return: { titulo: { lin_dig: nil } } })
        expect(subject.line).to eq(nil)
      end
    end

    context "is not nil" do
      it do
        expect(subject).to receive(:body).and_return({ return: { titulo: { lin_dig: "789101" } } })
        expect(subject.line).to eq("789101")
      end
    end
  end

  describe "#nosso_numero" do
    context "is nil" do
      it do
        expect(subject).to(
          receive(:body).and_return({ return: { titulo: { nosso_numero: nil } } })
        )
        expect(subject.nosso_numero).to eq(nil)
      end
    end

    context "is not nil" do
      it do
        expect(subject).to(
          receive(:body).and_return({ return: { titulo: { nosso_numero: "1112233" } } })
        )
        expect(subject.nosso_numero).to eq("1112233")
      end
    end
  end
end
