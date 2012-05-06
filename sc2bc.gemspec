# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sc2bc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jakub Arnold"]
  gem.email         = ["darthdeus@gmail.com"]
  gem.description   = %q{API Wrapper for SC2BC}
  gem.summary       = %q{Object oriented API wrapper for SC2BC API for generating brackets.}
  gem.homepage      = "http://sc2bc.com/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sc2bc"
  gem.require_paths = ["lib"]
  gem.version       = SC2BC::VERSION
end
