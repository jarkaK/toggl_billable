require 'pry'
require 'faraday'
require 'dotenv'
require 'json'
require 'date'

Dotenv.load

# require 'toggl_client/client.rb'
# require 'toggl_client/user.rb'
# require 'toggl_client/reports.rb'
# require 'toggl_client/billable_items.rb'

require_relative 'toggl_client/client.rb'
require_relative 'toggl_client/user.rb'
require_relative 'toggl_client/reports.rb'
require_relative 'toggl_client/billable_items.rb'