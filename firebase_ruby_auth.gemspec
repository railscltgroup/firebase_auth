# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'firebase-token-verify'
  s.version     = '0.1.0'
  s.date        = '2019-05-30'
  s.summary     = 'Authenticate Firebase User Tokens in Ruby'
  s.description = 'Firebase Ruby Auth'
  s.authors     = ['Emily Ring']
  s.email       = 'railsclt@gmail.com'
  s.files       = `git ls-files -- lib/*`.split("\n")
  s.test_files  = `git ls-files -- {spec}/*`.split("\n")
  s.homepage    = 'https://github.com/railscltgroup/firebase_auth'
  s.license     = 'MIT'

  s.add_dependency('jwt', '~> 2.2.2')

  s.add_development_dependency('activesupport', '~> 5.2.3')
  s.add_development_dependency('rspec-core', '~> 3.8.0')
  s.add_development_dependency('rspec-expectations', '~> 3.8.0')
  s.add_development_dependency('rspec-mocks', '~> 3.8.0')
  s.add_development_dependency('rubocop', '~> 0.71.0')
  s.add_development_dependency('simplecov', '~> 0.16.1')
  s.add_development_dependency('webmock', '~> 3.5.1')
end
