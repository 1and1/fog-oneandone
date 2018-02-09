# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fog-oneandone"
  spec.version       = "1.1"
  spec.authors       = ["Tyler Burkhardt (stackpointcloud.com)"]
  spec.email         = "tyler@stackpointcloud.com"
  spec.summary       = "Module for the 'fog' gem to support 1and1."
  spec.description   = "This library can be used as a module for 'fog' or as
                        a standalone 1and1 provider."
  spec.homepage      = "https://github.com/1and1/fog-oneandone"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fog-core"
  spec.add_runtime_dependency "fog-json"
  spec.add_development_dependency "minitest"
end