# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ox/builder/version'

Gem::Specification.new do |gem|
  gem.name          = "ox_builder"
  gem.version       = Ox::Builder::VERSION
  gem.authors       = ["undr"]
  gem.email         = ["undr@yandex.ru"]
  gem.description   = %q{XML builder with using ox}
  gem.summary       = %q{XML builder with using ox. Fast and convenient DSL.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'rake'
  gem.add_runtime_dependency 'ox'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
end
