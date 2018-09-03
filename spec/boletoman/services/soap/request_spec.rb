RSpec.describe Boletoman::Services::Soap::Request do
  describe '#call' do
    let(:response_class) { double(:response_class) }
    let(:response) { double(:response) }

    before do
      expect(subject).to receive_messages(response_class: response_class, response: response)
      expect(response_class).to receive(:new).with(response, subject).and_return(response)
    end

    context 'successfully response' do
      let(:response) { double(:response, success?: true) }
      it do
        expect(subject.call).to eq(response)
      end
    end

    context 'unsuccessfully response' do
      let(:response) { double(:response, success?: false, body: 'whatever') }
      it do
        expect(subject).to receive(:operation).and_return(:qualquer_operacao)
        expect { subject.call }.to(
          raise_error(RuntimeError, 'Falha ao chamar operação qualquer_operacao: whatever')
        )
      end
    end
  end

  describe "#response_class" do
    it do
      stub_const("Boletoman::Services::Soap::RequestResponse", Class.new)
      expect(subject).to receive(:class).and_return(Boletoman::Services::Soap::Request)
      expect(subject.response_class).to eq(Boletoman::Services::Soap::RequestResponse)
    end
  end

  describe "#response" do
    let(:client) { double(:client) }
    let(:operation) { double(:operation) }
    let(:message) { double(:message) }

    it do
      expect(subject).to receive_messages(client: client, operation: operation, message: message)
      expect(client).to receive(:call).with(operation, message: message).and_return(:whatever)
      expect(subject.response).to eq(:whatever)
    end
  end

  describe "#client" do
    it do
      allow(subject).to receive(:config_options).and_return(foo: :bar)
      expect(Savon).to receive(:client).with(foo: :bar)
      subject.client
    end
  end

  describe "#operation" do
    it do
      expect { subject.operation }.to raise_error(NotImplementedError)
    end
  end

  describe "#message" do
    it do
      expect { subject.message }.to raise_error(NotImplementedError)
    end
  end

  describe '#config_options' do
    it do
      expect(subject).to receive(:wsdl_config).and_return(foo: :bar)
      expect(subject).to receive(:extra_config_options).and_return(baz: :foo)
      expect(subject.config_options).to eq(foo: :bar, baz: :foo)
    end
  end

  describe '#wsdl_config' do
    it do
      expect(subject).to receive(:wsdl).and_return("whatever")
      expect(subject.wsdl_config).to eq(wsdl: "whatever")
    end
  end

  describe '#extra_config_options' do
    it do
      expect(subject.extra_config_options).to eq({})
    end
  end

  describe "#wsdl" do
    it do
      expect { subject.wsdl }.to raise_error(NotImplementedError)
    end
  end
end
