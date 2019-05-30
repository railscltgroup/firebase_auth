Gem::Specification.new do |s|
  s.name        = 'firebase_ruby_auth'
  s.version     = '0.0.2'
  s.date        = '2019-05-29'
  s.summary     = 'Authenticate Firebase User Tokens in Ruby'
  s.description = 'Firebase Ruby Auth'
  s.authors     = ['Emily Ring']
  s.email       = 'railsclt@gmail.com'
  s.files       = ["lib/firebase_ruby_auth.rb"]
  s.homepage    = 'https://github.com/railscltgroup/firebase_auth'
  s.license     = 'MIT'

  s.add_dependency('jwt', '~> 2.2.1')
  s.add_dependency('typhoeus', '~> 1.3')

  s.add_development_dependency('activesupport')
  s.add_development_dependency('rspec-core', '~> 3.8')
  s.add_development_dependency('rspec-expectations', '~> 3.8')
  s.add_development_dependency('rspec-mocks', '~> 3.8')
  s.add_development_dependency('webmock', '~> 3.5')
end
