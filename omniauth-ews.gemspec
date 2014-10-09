# encoding: utf-8
require File.expand_path('../lib/omniauth-ews/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-http-basic', '~> 1.0'
  gem.add_dependency 'viewpoint', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'

  gem.authors = ['Alex rojo']
  gem.email = ['arojo@gynaika.net']
  gem.description = %q{Exchange Web Services strategy for OmniAuth.}
  gem.summary = gem.description
  gem.homepage = 'https://github.com/arojoal/omniauth-ews'

  gem.name = 'omniauth-ews'
  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = OmniAuth::Ews::VERSION
  gem.license = 'GPL-2.0+'
end