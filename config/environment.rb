require 'bundler'
require 'rake'
require 'active_record'
require 'faker'
Bundler.require

require 'bundler/setup'
require 'sinatra/activerecord'

Dir[File.join(File.dirname(__FILE__), '../app/models', '*.rb')].each { |f| require f }
connection_details = YAML.safe_load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

require_all 'app'
require_all 'lib'










