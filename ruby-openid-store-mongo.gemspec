# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openid/store/mongo'

Gem::Specification.new do |spec|
  spec.name          = "ruby-openid-store-mongo"
  spec.version       = OpenID::Store::Mongo::VERSION
  spec.authors       = ["Kevin McGrath"]
  spec.email         = ["kevin.mcgrath@sungard.com"]
  spec.description   = %q{MongoDB store for ruby-openid}
  spec.summary       = %q{MongoDB store for ruby-openid}
  spec.homepage      = ""
  spec.license       = ["Ruby", "Apache Software License 2.0"]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
