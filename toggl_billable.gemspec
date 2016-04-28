# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = 'toggl_billable'
  gem.version       = '0.1.3'
  gem.date          = '2016-03-12'
  gem.summary       = "Basic operations with toggl API"
  gem.description   = "A simple gem that enables to communicate with toggl API. Main Purpose is to receive items for invoicing."

  gem.authors       = ["Jaroslava Kadlecova"]
  gem.homepage      = "http://github.com/jarkadlec/toggl_billable"
  gem.email         = 'kadlecovaj@gmail.com'
  gem.license       = 'MIT'

  gem.require_paths = ["lib"]
  gem.files         = Dir['lib/**/*.rb']

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency 'faraday', '~>0.8'
  gem.add_dependency 'json', '~>1.6'
  gem.add_dependency 'rake'

  gem.add_development_dependency 'vcr', '~>2.5'
  gem.add_development_dependency 'webmock', '~>1.5'
  gem.add_development_dependency 'rspec', '~>2.5'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'timecop', ['~> 0.6']
end
