# -*- encoding: utf-8 -*-
require File.expand_path('../lib/i18n-airbrake/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["iain"]
  gem.email         = ["iain@iain.nl"]
  gem.description   = %q{Notifies Airbrake when you miss a translation}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/iain/i18n-airbrake"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "i18n-airbrake"
  gem.require_paths = ["lib"]
  gem.version       = I18n::Airbrake::VERSION

  gem.add_dependency "i18n", "~> 0.6"
  gem.add_dependency "airbrake", "~> 3.0"

  gem.add_development_dependency "rspec", "~> 2.9"

end
