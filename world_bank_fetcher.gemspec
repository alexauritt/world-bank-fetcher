# -*- encoding: utf-8 -*-
require File.expand_path('../lib/world_bank_fetcher/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander Auritt"]
  gem.email         = ["alexauritt@gmail.com"]
  gem.description   = %q{For caching WorldBank data in a local db}
  gem.summary       = %q{Fetches local WorldBank country and indicator data.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "world_bank_fetcher"
  gem.require_paths = ["lib"]
  gem.version       = WorldBankFetcher::VERSION
  
  gem.add_development_dependency "rspec"
  gem.add_dependency "rake"
end
