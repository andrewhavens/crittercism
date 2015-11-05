# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "crittercism"
  spec.version       = "0.1.0"
  spec.authors       = ["Andrew Havens"]
  spec.email         = ["email@andrewhavens.com"]

  spec.summary       = %q{Crash reporting for your RubyMotion app.}
  spec.homepage      = "https://github.com/andrewhavens/crittercism"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["ruby_lib"]

  spec.add_runtime_dependency "motion-cocoapods"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
