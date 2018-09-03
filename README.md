# Boletoman

[![Build Status](https://travis-ci.org/glaucocustodio/boletoman.svg?branch=master)](https://travis-ci.org/glaucocustodio/boletoman)
[![Coverage Status](https://coveralls.io/repos/github/glaucocustodio/boletoman/badge.svg?branch=master)](https://coveralls.io/github/glaucocustodio/boletoman?branch=master)

Gema responsável por gerar boletos em pdf para bancos brasileiros que requerem chamada a serviços web para obter o código de barras previamente. Bancos suportados no momento:

- Itaú (API de Registro de Cobrança)
- Santander (SOAP Cobrança Online)

Usa a gema Bbrcobranca para gerar os arquivos pdf.

## Instalação

Adicione a linha no seu Gemfile

```ruby
gem 'boletoman'
```

Execute:

    $ bundle

Ou instale você mesmo:

    $ gem install boletoman

## Uso

### Itaú

Chamadas implementadas:

- geração de token autorizador
- geração de boleto

Configure o acesso, se estiver no Rails, pode ser colocado em `config/initializers/boletoman.rb`:

```ruby
Boletoman.configure do |config|
  config.env = :production # qualquer outro symbol será considerado ambiente de desenvolvimento
  config.redis = $redis # instancia do redis para cachear o token

  config.itau = Boletoman::Itau.configure do |itau_config|
    itau_config.client_id = 'kl3j2423'
    itau_config.client_secret = 'w2H-DWAd2lkjdwa2323ADwad3232dwa1209709lj1l098jUUy2fb9XlsrQ2'
    itau_config.key = '4t5g129w-61wt-78e0-io70-lo10178h6711'
    itau_config.identificator = '87987098709871'
  end
end
```

Passe os dados e faça a chamada:

```ruby
builder = Boletoman::Builders::Itau.new({
  # dados do cedente
  transferor: {
    name: 'EMPRESA CEDENTE LTDA',
    document: '86.521.120/0001-50', # cnpj
    branch: '0036', # agencia
    checking_account: '119097', # conta
    wallet: '109', # carteira
  },
  # dados do pagador
  payer: {
    document: '714.295.500-74', # cpf
    name: 'JOSE SILVA',
    street: 'Rua Edson Pereira Dias, 123',
    city: 'Sumaré',
    state: 'SP',
    zip_code: '17535-004',
  },
  # dados do boleto
  boleto: {
    due_date: Date.new(2018, 12, 20),
    nosso_numero: '10030033',
    value: 520.80,
  }
})

pdf = builder.build

IO.binwrite('boleto-itau.pdf', pdf) # salva binário no arquivo
```

### Santander

Chamadas implementadas:

- consulta título
- registra título
- solicitação de ticket de segurança

Configure o acesso, se estiver no Rails, pode ser colocado em `config/initializers/boletoman.rb`:

```ruby
Boletoman.configure do |config|
  config.env = :production # qualquer outro symbol será considerado ambiente de desenvolvimento

  config.santander = Boletoman::Santander.configure do |santander|
    santander.station = '1A2B'
    santander.covenant = '1234567'
    # em caso de querer passar certificado via proxy do nginx por ex, defina:
    santander.use_certificate = false
    santander.ticket_wsdl_url = 'https://meuproxy.com/dl-ticket-services/TicketEndpointService/TicketEndpointService.wsdl'
  end
end
```

Passe os dados e faça a chamada:

```ruby
builder = Boletoman::Builders::Santander.new({
  # dados do cedente
  transferor: {
    name: 'EMPRESA CEDENTE LTDA',
    document: '86.521.120/0001-50', # cnpj
    branch: '0036', # agencia
    checking_account: '119097', # conta
    wallet: '109', # carteira
  },
  # dados do pagador
  payer: {
    document: '714.295.500-74', # cpf
    name: 'JOSE SILVA',
    street: 'Rua Edson Pereira Dias, 123',
    city: 'Sumaré',
    state: 'SP',
    zip_code: '17535-004',
  },
  # dados do boleto
  boleto: {
    due_date: Date.new(2018, 12, 20),
    nosso_numero: '10030033',
    value: 520.80,
  }
})

pdf = builder.build

IO.binwrite('boleto-santander.pdf', pdf) # salva binário no arquivo
```

Consultando um boleto:

```ruby
Boletoman::Services::Santander::Query::Facade.new(nsu).call # NSU do banco

# => { barcode: '03923500000671005391763800000098669934890101', line: '0317176380000009866399934952350000067610058901' }
```

## Desenvolvimento

### Testes

`rake spec`

### Console

`bundle console`

### Release

Atualize o número da versão em `version.rb` e rode:

`bundle exec rake release`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
