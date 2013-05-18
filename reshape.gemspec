# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reshape/version'

Gem::Specification.new do |gem|
  gem.name          = "reshape"
  gem.version       = Reshape::VERSION
  gem.authors       = ["John Barton"]
  gem.email         = ["jb@phy5ics.com"]
  gem.description   = %q{A client for the Shapeways 3D printing API.}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/phy5ics/reshape"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'faraday', '~> 0.8.4'
  gem.add_dependency 'faraday_middleware', '~> 0.8.4'
  gem.add_dependency 'hashie', '~> 1.2'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_dependency 'multi_xml', '~> 0.5.0'
  
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  
end
