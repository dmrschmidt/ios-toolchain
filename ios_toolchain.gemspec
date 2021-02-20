# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ios_toolchain/version'

Gem::Specification.new do |spec|
  spec.name          = "ios_toolchain"
  spec.version       = IosToolchain::VERSION
  spec.authors       = ["Dennis Schmidt"]
  spec.email         = ["dmrschmidt@gmail.com"]

  spec.summary       = "Collection of rake tasks and scripts to ease iOS development."
  spec.description   = "Collection of rake tasks and scripts to ease iOS development."
  spec.homepage      = "http://github.com/dmrschmidt/ios-toolchain"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "xcodeproj", "~> 1.4"
  spec.add_dependency "xcpretty", "~> 0.2"
end
