
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "boletoman/version"

Gem::Specification.new do |spec|
  spec.name          = "boletoman"
  spec.version       = Boletoman::VERSION
  spec.authors       = ["Glauco Custódio"]
  spec.email         = ["glauco.custodio@gmail.com"]

  spec.summary       = %q{Gerador de boletos registrados.}
  spec.description   = %q{Gerador de boletos registrados.}
  spec.homepage      = "https://github.com/glaucocustodio/boletoman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "fakeredis"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "awesome_print"

  spec.add_dependency 'faraday'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'bbrcobranca'
  spec.add_dependency 'savon'
end
