# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ios/toolchain/version'

Gem::Specification.new do |spec|
  spec.name          = "ios-toolchain"
  spec.version       = Ios::Toolchain::VERSION
  spec.authors       = ["Dennis Schmidt"]
  spec.email         = ["dschmidt@pivotal.io"]

  spec.summary       = "Collection of rake tasks and scripts to ease iOS development."
  spec.description   = "Collection of rake tasks and scripts to ease iOS development."
  spec.homepage      = "http://github.com/dmrschmidt/ios-toolchain"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "rake", "~> 10.0"
end
