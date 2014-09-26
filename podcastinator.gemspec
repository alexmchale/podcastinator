# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'podcastinator/version'

Gem::Specification.new do |spec|
  spec.name          = "podcastinator"
  spec.version       = Podcastinator::VERSION
  spec.authors       = ["Alex McHale"]
  spec.email         = ["alex@anticlever.com"]
  spec.summary       = %q{A ruby library for generating podcast feeds.}
  spec.description   = %q{A ruby library for generating podcast feeds from a source or via an API.}
  spec.homepage      = "http://github.com/alexmchale/podcastinator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.6"
  spec.add_dependency "taglib-ruby", ">= 0.6"
  spec.add_dependency "mime-types", ">= 1.25"

  spec.add_development_dependency "bundler", ">= 1.6"
  spec.add_development_dependency "rake", ">= 10.3"
end
