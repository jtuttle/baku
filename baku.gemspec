lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baku/version'

Gem::Specification.new do |spec|
  spec.name          = 'baku'
  spec.version       = Baku::VERSION
  spec.authors       = ['John Tuttle']
  spec.email         = ['jtuttle.develops@gmail.com']

  spec.summary       = 'An Entity Component System framework for Ruby'
  spec.description   = 'An Entity Component System framework for Ruby'
  spec.homepage      = 'https://github.com/jtuttle/baku'
  spec.license       = 'MIT'

  # use double quotes for "\x0" (https://github.com/bundler/bundler/issues/4133)
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.5.0'
end
