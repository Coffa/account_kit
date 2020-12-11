# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'account_kit/version'

Gem::Specification.new do |spec|
  spec.name          = "account_kit"
  spec.version       = AccountKit::VERSION
  spec.authors       = ["Duc Le", "Long Nguyen", "Quy Truong", "Vu Minh Tan"]
  spec.email         = ["leminhducktvn@gmail.com", "longkt90@gmail.com", "sugiacupit@gmail.com"]

  spec.homepage      = "https://github.com/Coffa/account_kit"
  spec.summary       = %q{A light-weight Ruby API client for Facebook Account Kit with no dependency.}
  spec.description   = %q{A light-weight Ruby API client for Facebook Account Kit with no dependency.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
