Gem::Specification.new do |s|
  s.name        = 'firebase_ruby_auth'
  s.version     = '0.0.0'
  s.date        = '2019-03-30'
  s.summary     = 'Authenticate Firebase User Tokens in Ruby'
  s.description = 'Firebase Ruby Auth'
  s.authors     = ['Emily Ring']
  s.email       = 'railsclt@gmail.com'
  s.files       = ["lib/firebase_ruby_auth.rb"]
  s.homepage    = 'https://github.com/railscltgroup/firebase_auth'
  s.license     = 'MIT'

  s.add_dependency('jwt', '~> 2.2.0.pre.beta.0')
  s.add_dependency('typhoeus', '~> 1.3')
end
