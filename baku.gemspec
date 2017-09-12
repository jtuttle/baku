# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "baku/version"

Gem::Specification.new do |spec|
  spec.name          = "baku"
  spec.version       = Baku::VERSION
  spec.authors       = ["John Tuttle"]
  spec.email         = ["jtuttle.develops@gmail.com"]

  spec.summary       = "An Entity Component System framework for Ruby"
  spec.description   = "An Entity Component System framework for Ruby"
  spec.homepage      = "https://github.com/jtuttle/baku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
