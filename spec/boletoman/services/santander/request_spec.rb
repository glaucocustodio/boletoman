RSpec.describe Boletoman::Services::Santander::Request do
  describe "#extra_config_options" do
    context "requires certificate" do
      before do
        expect(subject).to receive(:requires_certificate?).and_return(true)
        allow(Boletoman).to(
          receive_message_chain('configuration.santander.configuration.certificate').and_return(
            '/path/to/certificate'
          )
        )
        allow(Boletoman).to(
          receive_message_chain('configuration.santander.configuration.certificate_key').and_return(
            '/path/to/certificate_key'
          )
        )
        allow(File).to receive(:exist?).with('/path/to/certificate').and_return(true)
        allow(File).to receive(:exist?).with('/path/to/certificate_key').and_return(true)
      end

      context 'certificate file does not exist' do
        it do
          expect(File).to(
            receive(:exist?).with('/path/to/certificate').and_return(false)
          )
          expect { subject.extra_config_options }.to raise_error(
            RuntimeError, "Arquivo do certificado não existe"
          )
        end
      end

      context 'certificate key file does not exist' do
        it do
          expect(File).to(
            receive(:exist?).with('/path/to/certificate_key').and_return(false)
          )
          expect { subject.extra_config_options }.to raise_error(
            RuntimeError, "Arquivo chave do certificado não existe"
          )
        end
      end

      context 'certificate and certificate key files exist' do
        it do
          expect(subject.extra_config_options).to include(:ssl_cert_file, :ssl_cert_key_file)
        end
      end
    end

    context "does not require certificate" do
      it do
        expect(subject).to receive(:requires_certificate?).and_return(false)
        expect(subject.extra_config_options).to eq({})
      end
    end
  end

  describe "#requires_certificate?" do
    it do
      expect { subject.requires_certificate? }.to raise_error(NotImplementedError)
    end
  end
end
