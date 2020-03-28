# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "covid19cli/version"

Gem::Specification.new do |spec|
  spec.name          = Covid19cli::COMMAND
  spec.version       = Covid19cli::VERSION
  spec.authors       = ["dkhamsing"]
  spec.email         = ["dkhamsing8@gmail.com"]

  spec.summary       = 'Quick CLI for COVID-19 data'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dkhamsing/covid19cli'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = [spec.name]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'terminal-table', '~> 1.8.0'
end
