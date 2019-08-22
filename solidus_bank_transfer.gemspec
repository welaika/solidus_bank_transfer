# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'solidus_bank_transfer/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_bank_transfer'
  s.version     = SolidusBankTransfer::VERSION
  s.summary     = 'Bank Transfer'
  s.description = 'Bank Transfer'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Fabrizio Monti'
  s.email     = 'fabrizio.monti@welaika.com'
  s.homepage  = 'https://dev.welaika.com'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'solidus_core', '~> 2.8', '>= 2.8.2'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'pry-byebug', '~> 3.7'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-performance'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver', '~> 3.142'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webdrivers', '~> 4.0'
end
