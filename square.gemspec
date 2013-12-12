Gem::Specification.new do |gem|
  gem.name          = "square"
  gem.version       = File.read("VERSION").delete("\n\r")
  gem.authors       = ["nov"]
  gem.email         = ["nov@matake.jp"]
  gem.description   = %q{Square API client}
  gem.summary       = %q{Square API Client}
  gem.homepage      = "https://github.com/nov/square"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end
