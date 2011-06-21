ENV['RAILS_ENV'] = 'test'

require File.expand_path('../test_app/config/environment', __FILE__)

require 'rspec/rails'
require 'factory_girl'
require 'factories'
require 'database_helpers'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each{|f| require f}

include DatabaseHelpers
# Run any available migration
puts 'Setting up database...'
drop_all_tables
migrate_database
