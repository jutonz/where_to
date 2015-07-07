# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'where_to/version'

Gem::Specification.new do |spec|
  spec.name          = "where_to"
  spec.version       = WhereTo::VERSION
  spec.authors       = ["Justin Toniazzo"]
  spec.email         = ["jutonz42@gmail.com"]

  spec.license       = 'MIT'

  spec.summary       = "Helps preserve a folder structure for mediafiles"
  spec.homepage      = "https://github.com/jutonz/where_to"

  spec.platform      = Gem::Platform::RUBY
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.bindir        = "bin"
  spec.executables   << "whereto"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "simplecov", "~> 0.10.0"
  spec.add_development_dependency "coveralls", "~> 0.8.1"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "parallel_tests", "~> 1.5"

  spec.add_dependency "tvdb_party", "~> 0.8.0"

  spec.add_runtime_dependency "gli", "2.13.1"
end
