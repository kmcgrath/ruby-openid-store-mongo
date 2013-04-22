# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "ruby-openid-store-mongo"
  spec.version       = "0.0.3"
  spec.authors       = ["Kevin McGrath"]
  spec.email         = ["kevin.mcgrath@sungard.com"]
  spec.description   = %q{MongoDB store for ruby-openid}
  spec.summary       = %q{MongoDB store for ruby-openid}
  spec.homepage      = "https://github.com/kmcgrath/ruby-openid-store-mongo"
  spec.licenses      = ["Ruby", "Apache Software License 2.0"]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "ruby-openid", ["~> 2.1"]
end
