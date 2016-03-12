require 'rspec'
require 'vcr'
require 'timecop'

require_relative '../lib/toggl_client.rb'

TEST_API_TOKEN = '2dacc2a49d88af72a08887a9cc47e777'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.color = true

  config.before(:all) do
    TogglClient::Client.start(TEST_API_TOKEN)
  end

  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].split(' ').first.gsub('::', '/').gsub('#', '/')
      VCR.use_cassette(name, options, &example)
    end
  end

end
