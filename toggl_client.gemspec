# require File.expand_path('../lib/olery/api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'toggl_client'
  gem.version       = '0.0.0'
  gem.date          = '2016-02-20'
  gem.summary       = "Basic operations with toggl API"
  gem.description   = "A simple gem that enables to communicate with toggl API.
    Main Purpose is to receive items for invoicing."
  gem.authors       = ["Jaroslava Kadlecova"]
  gem.email         = 'kadlecovaj@gmail.com'
  # gem.require_paths = ["lib"]
  gem.files = Dir.glob(['lib/**/*.rb']).select { |file| File.file?(file) }
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0'

  gem.add_dependency 'faraday', '~>0.8'
  gem.add_dependency 'json', '~>1.6'
  gem.add_dependency 'dotenv', '~>2.0'

  gem.add_development_dependency 'vcr', '~>2.5'
  gem.add_development_dependency 'webmock', '~>1.5'
  gem.add_development_dependency 'rspec', '~>2.5'
  gem.add_development_dependency 'pry'
end