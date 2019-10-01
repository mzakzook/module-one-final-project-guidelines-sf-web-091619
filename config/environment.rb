require 'bundler'
require 'rake'
require 'active_record'
require 'faker'
Bundler.require
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require 'bundler/setup'
require 'sinatra/activerecord'

Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }
connection_details = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

require_all 'app'
require_all 'lib'