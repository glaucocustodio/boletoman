# Boletoman

Gema responsável por gerar boletos em pdf para bancos brasileiros que requerem chamada a serviços web para obter o código de barras previamente. Bancos suportados no momento:

- Itaú (API de Registro de Cobrança)

## Installation

Adicione a linha no seu Gemfile

```ruby
gem 'boletoman'
```

Execute:

    $ bundle

Ou instale você mesmo:

    $ gem install boletoman

## Uso

### Itau

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

IO.binwrite('boleto.pdf', pdf) # salva binário no arquivo
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
